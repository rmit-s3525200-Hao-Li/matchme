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
  
  validates :user_id, presence: true
  
  validates :gender, presence: true
  validates :occupation, length: {maximum: 50}
  validates :city, presence: true, length: {maximum: 60}
  validates :post_code, presence: true, length: {maximum: 20}
  validates :country, presence: true
  validates :self_summary, length: {maximum: 800}
  validates :preferred_gender, presence: true
  validates :min_age, presence: true, numericality: { greater_than_or_equal_to: 18 }
  validates :max_age, presence: true, numericality: { greater_than_or_equal_to: :min_age }
  validates :date_of_birth, presence: true
  validates :looking_for, presence: true
  validates :edu_status, presence: true
  validates :edu_type, presence: true
  
  # Custom validation methods
  validate(:picture_size)
  validate(:minimum_age)
  
  # Geocoding to produce latitude and longitude
  geocoded_by :address
  after_validation :geocode
  
  # return string of first and last name
  def name
    "#{first_name} #{last_name}".titleize
  end
  
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
  
  def address
    "#{city}, #{post_code}, #{country}"
  end
  
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
  
  def count_interests
    interests_array.flatten.size
  end
  
  private
  
    def downcase_occupation
      self.occupation.downcase!
    end
    
    # Ensures the uploaded image isn't too big
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
    def minimum_age
      if age < 18
        errors.add(:date_of_birth, "- You must be at least 18 to register")
      end
    end
    
    def create_matches
      users = User.all
      users.each do |u|
        # Check that user is not an admin or current user
        unless u.id == self.user_id || u.admin?
          Match.create!(user_one_id: self.user_id, user_two_id: u.id)
        end
      end
    end
    
end
