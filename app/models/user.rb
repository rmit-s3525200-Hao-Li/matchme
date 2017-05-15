class User < ApplicationRecord
  
  has_one :profile, dependent: :destroy
  
  attr_accessor :remember_token
  before_save :downcase_email
  
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
                                  
  has_many :following, through: :active_relationships, source: :followed 
  
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
                                   
   has_many :followers, through: :passive_relationships, source: :follower                                 
  # Validates email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  # Validates password
  VALID_PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/
  has_secure_password
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true
  
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
  
  # Gets match users
  def matches
    Match.where("user_one_id = ? OR user_two_id = ?", self.id, self.id).order(percent: :desc)
  end
  
  def match_users
    match_users = Array.new
    self.matches.each do |m|
      if m.user_one_id != self.id
        match_users.push(m.user_one_id)
      else
        match_users.push(m.user_two_id)
      end
    end
    User.find(match_users)
  end
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  def following?(user)
    following.include?(user)
  end
  
  def self.search(search)
    if search
      profiles = Profile.where('lower(name) LIKE ?', "%#{search.downcase}%")
      user_ids = profiles.pluck(:user_id)
      self.find(user_ids)
    else
      self.all
    end
  end
  
  private
  
    # Converts email to all lower-case
    def downcase_email
      self.email.downcase!
    end

end
