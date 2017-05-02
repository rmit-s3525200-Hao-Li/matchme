class Match < ApplicationRecord
  validates :user_one_id, presence: true
  validates :user_two_id, presence: true
  
  def profile_one
    User.find(user_one_id).profile
  end
  
  def profile_two
    User.find(user_two_id).profile
  end
  
  def percent
    match_percent = 0
    if profile_one.preferred_gender != "both" || profile_one.preferred_gender != profile_two.gender
      if profile_two.preferred_gender == "both" || profile_two.preferred_gender == profile_one.gender
        match_percent = match_interests
      end
    end    
    match_percent
  end
  
  private
  
    def match_interests
      interests_one = profile_one.interests_array.map{|i| i.downcase}
      interests_two = profile_two.interests_array.map{|i| i.downcase}
      total_interests = profile_one.count_interests + profile_two.count_interests
      common_interests = interests_one.zip(interests_two).flat_map { |f, s| f & s }.count
      ((common_interests.to_f / total_interests) * 100).round
    end
    
    def match_profile
      points = 0
      if profile_one.occupation == profile_two.occupation
        points += 5
      end
      if profile_one.religion == profile_two.religion
        points += 15
      end
      if profile_one.smoke == profile_two.smoke
        points += 15
      end
      if profile_one.religion == profile_two.religion
        points += 15
      end
    end
  
end
