class Profile < ApplicationRecord
  belongs_to :user
  
  before_save :downcase_occupation
  
  # Create matches for this user
  after_create :create_matches
  
  # CarrierWave method for image uploading
  mount_uploader :picture, PictureUploader
  
  # Validations for required fields
  # validates(:user_id, presence: true)
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length:  { maximum: 25 }
  
  validates :occupation, presence: true, length: {maximum: 50}
  validates :city, presence: true, length: {maximum: 60}
  validates :post_code, presence: true, length: {maximum: 20}
  validates :self_summary, length: {maximum: 800}
  validates :preferred_gender, presence: true
  validates :min_age, presence: true, numericality: { greater_than_or_equal_to: 18 }
  validates :max_age, presence: true, numericality: { greater_than_or_equal_to: :min_age }
  validates :user_id, :gender, :date_of_birth, :country, :looking_for, 
            :edu_status, :edu_type, :religion, :smoke, :drink, :drugs, 
            :diet, presence: true
  
  # Custom validation methods
  validate :picture_size
  validate :minimum_age
  
  # Geocoding to produce latitude and longitude
  geocoded_by :address
  after_validation :geocode
  
  # return string of first and last name
  def name
    "#{first_name} #{last_name}".titleize
  end
  
  # turns education fields into single string
  def education
    "#{edu_status} #{edu_type}"
  end
  
  # convert education level into numeric form
  def edu_num
    num = 0
    # check status
    case edu_status
    when "working on"
      num += 5
    when "completed"
      num += 10
    end
    # check institution
    case edu_type
    when "two-year college"
      num += 5
    when "university"
      num += 10
    when "post grad"
      num += 15
    end
    num
  end

  # return age
  def age(dob=self.date_of_birth)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
  
  # turns location inputs into single string
  def address
    "#{city}, #{post_code}, #{country}"
  end
  
  # takes all interests and creates a nested array
  def interests_array
    attributes = [hobbies, movies, tv_shows, books, games, sports]
    interests = Array.new
    attributes.each do |a|
      if !a.blank?
        a.titleize
        interests.push(a.split(/\s*,\s*/))
      else
        interests.push([])
      end
    end
    interests
  end
  
  # counts total number of interests user has
  def count_interests
    interests_array.flatten.size
  end
  
  # Creates array from min and max age
  def age_range
    (min_age..max_age).to_a
  end
  
  def gender_array
    if self.preferred_gender == "both"
      ["male", "female"]
    else
      [self.preferred_gender]
    end
  end
  
  private
  
    # Downcase occupation upon save
    def downcase_occupation
      self.occupation.downcase!
    end
    
    # Ensures the uploaded image isn't too big
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
    # Minimum age validaiton
    def minimum_age
      if age < 18
        errors.add(:date_of_birth, "- You must be at least 18 to register")
      end
    end
    
    # Create match objects
    def create_matches
      # Checks for location match
      profiles = match_location
      
      # Match by gender
      profiles = match_gender(profiles)
      
      # Get users from ids
      user_ids = profiles.pluck(:user_id)
      users = User.find(user_ids)
      
      # Create matches
      users.each do |u|
        Match.create!(user_one_id: self.user_id, user_two_id: u.id)
      end
    end
    
    # Returns profiles either 15 or 50 miles away (or anywhere)
    def match_location
      if self.nearby = true && self.nearbys(15).any?
        profiles = self.nearbys(15, {order: ""} )
      else
        profiles = self.nearbys(50, {order: ""} )
        if !profiles.any?
          profiles = Profile.where.not(user_id: self.user_id)
        end
      end
      profiles
    end
    
    # Checks for gender match
    def match_gender(profiles)
      if preferred_gender != "both"
        profiles.where("preferred_gender = ? OR preferred_gender = ?", self.gender, "both")
      else
        profiles.where("preferred_gender = ? OR preferred_gender = ?, gender = ?", self.gender, "both", self.preferred_gender)
      end
    end
    
end
