class User < ApplicationRecord
    before_save { email.downcase! }
    validates(:first_name, presence: true, length: { maximum: 25 })
    validates(:last_name, presence: true, length: { maximum: 25 })
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
    VALID_PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/
    has_secure_password
    validates(:password, presence: true, format: { with: VALID_PASSWORD_REGEX })
    validates(:gender, presence: true)
    validates(:orientation, presence: true)
    validates(:occupation, presence: true, length: {maximum: 50})
    validates(:religion, presence: true)
    validates(:city, presence: true, length: {maximum: 60})
    validates(:post_code, presence: true, length: {maximum: 20})
    validates(:country, presence: true)
    validates(:self_summary, presence: true, length: {maximum: 500})
    validates(:preferred_gender, presence: true)
    validates(:min_age, presence: true)
    validates(:max_age, presence: true)
    validates(:date_of_birth, presence: true)
    
    #mount_uploader :image, ImageUploader
    
    #backwards-compatible readers
    def name
      "#{first_name} #{last_name}"
    end
  
    def age(dob=self.date_of_birth)
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
    
end
