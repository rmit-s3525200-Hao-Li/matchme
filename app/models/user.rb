class User < ApplicationRecord
  attr_accessor :remember_token
  
  before_save :downcase_email
  
  validates(:first_name, presence: true, length: { maximum: 25 })
  validates(:last_name, presence: true, length: { maximum: 25 })
  
  # Validates email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  # Validates password
  VALID_PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/
  has_secure_password
  validates(:password, presence: true, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true)
  
  validates(:gender, presence: true)
  validates(:occupation, presence: true, length: {maximum: 50})
  validates(:religion, presence: true)
  validates(:city, presence: true, length: {maximum: 60})
  validates(:post_code, presence: true, length: {maximum: 20})
  validates(:country, presence: true)
  validates(:self_summary, length: {maximum: 500})
  validates(:preferred_gender, presence: true)
  validates(:min_age, presence: true, numericality: { greater_than_or_equal_to: 18 })
  validates(:max_age, presence: true, numericality: { greater_than_or_equal_to: :min_age })
  validates(:date_of_birth, presence: true)
  validates(:looking_for, presence: true)
  
  #mount_uploader :image, ImageUploader
  
  # return string of first and last name
  def name
    "#{first_name} #{last_name}"
  end

  # return age
  def age(dob=self.date_of_birth)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
    
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def address
    "#{city}, #{post_code}, #{country}"
  end
  
  # Geocoding to produce latitude and longitude
  geocoded_by :address
  after_validation :geocode
  
  private
  
    # Converts email to all lower-caes
    def downcase_email
      self.email.downcase!
    end
end
