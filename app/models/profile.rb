class Profile < ApplicationRecord
  belongs_to :user
  
  before_save :titleize_occupation
  
  # CarrierWave method for image uploading
  mount_uploader :picture, PictureUploader
  
  # Validations for required fields
  validates(:user_id, presence: true)
  validates(:first_name, presence: true, length: { maximum: 25 })
  validates(:last_name, presence: true, length: { maximum: 25 })
  
  validates(:gender, presence: true)
  validates(:occupation, length: {maximum: 50})
  validates(:city, presence: true, length: {maximum: 60})
  validates(:post_code, presence: true, length: {maximum: 20})
  validates(:country, presence: true)
  validates(:self_summary, length: {maximum: 500})
  validates(:preferred_gender, presence: true)
  validates(:min_age, presence: true, numericality: { greater_than_or_equal_to: 18 })
  validates(:max_age, presence: true, numericality: { greater_than_or_equal_to: :min_age })
  validates(:date_of_birth, presence: true)
  validates(:looking_for, presence: true)
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

  # return age
  def age(dob=self.date_of_birth)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
  
  def address
    "#{city}, #{post_code}, #{country}"
  end
  
  private 
    def titleize_occupation
      self.occupation.titleize
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
    
end
