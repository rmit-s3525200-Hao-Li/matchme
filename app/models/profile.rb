class Profile < ApplicationRecord
  include ActiveModel::Dirty
  
  belongs_to :user
  
  before_save :downcase_occupation
  
  # Create matches for this user
  after_create :create_matches
  
  # Check if certain attributes were changed, and updates matches accordingly
  after_update :check_changes
  
  # Create name from first_name and last_name, for searching purposes
  after_save :create_name
  
  # CarrierWave method for image uploading
  mount_uploader :picture, PictureUploader
  
  # Validations for required fields
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length:  { maximum: 25 }
  
  validates :occupation, presence: true, length: {maximum: 50}
  validates :city, presence: true, length: {maximum: 60}
  validates :post_code, presence: true, length: {maximum: 20}
  validates :self_summary, length: {maximum: 800}
  validates :preferred_gender, length: {minimum: 4, maximum: 6}, presence: true
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
  
  # convert smoker status into numeric form
  def smoke_num
    num = 0
    case smoke
    when "sometimes"
      num += 5
    when "often"
      num += 10
    end
    num
  end
  
  # convert drink status into numeric form
  def drink_num
    num = 0
    case drink
    when "socially"
      num += 5
    when "often"
      num += 10
    end
    num
  end
  
  # convert drug use status into numeric form
  def drugs_num
    num = 0
    case drugs
    when "sometimes"
      num += 5
    when "often"
      num += 10
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
    attributes = [hobbies, movies, music, tv_shows, books, games, sports]
    interests = Array.new
    attributes.each do |a|
      if !a.blank?
        a.downcase
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
  
  # Check if location or gender attributes are updated
  def location_gender_updated?
    [:post_code, :preferred_gender, :gender, :nearby].any? do |attribute|
       __send__(:"#{attribute}_changed?")
    end
  end
    
  # Check if profile attributes that affect match percent are updated
  def profile_updated?
    [:occupation, :date_of_birth, :religion, :smoke, :drink, :drugs, 
      :diet, :looking_for, :edu_status, :edu_type, :hobbies, :movies, 
      :tv_shows, :books, :games, :sports].any? do |attribute|
       __send__(:"#{attribute}_changed?")
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
  
  private
  
    # Create name
    def create_name
      name = "#{first_name} #{last_name}".titleize
      self.update_column(:name, name)
    end
  
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
    
    # Returns profiles either 15 or 50 miles away (or anywhere)
    def match_location
      if self.nearby == true && self.nearbys(15).any?
        profiles = self.nearbys(15, {order: ""} )
      else
        profiles = self.nearbys(50, {order: ""} )
      end
      profiles
    end
    
    # Checks for gender match
    def match_gender(profiles)
      profiles = profiles.where("preferred_gender = ? OR preferred_gender = ?", self.gender, "both")
      if preferred_gender != "both"
        profiles = profiles.where(gender: self.preferred_gender)
      end
      profiles
    end
    
    # Check for changes and update matches accordingly
    def check_changes
      # Matches  need to be recreated 
      # because they are filtered by location and gender
      if self.location_gender_updated?
        self.user.matches.destroy_all
        create_matches
      # Minor profile updates only require an update to
      # match percent
      elsif self.profile_updated?
        self.user.matches.each do |m|
          m.update_percent
        end
      end
    end
    
end
