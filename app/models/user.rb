class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  #accepts_nested_attributes_for :profile, reject_if: :all_blank, allow_destroy: true
  attr_accessor :remember_token
  before_save :downcase_email
  
  # Validates email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  # Validates password
  VALID_PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/
  has_secure_password
  validates(:password, presence: true, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true)
  
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
  
  private
  
    # Converts email to all lower-caes
    def downcase_email
      self.email.downcase!
    end

end
