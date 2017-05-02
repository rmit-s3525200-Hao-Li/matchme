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
    (match_interests.to_f + match_profile / 2).round
  end
  
  private
  
    # match percent based interests attributes
    def match_interests
      interests_one = profile_one.interests_array
      interests_two = profile_two.interests_array
      total_interests = profile_one.count_interests + profile_two.count_interests
      common_interests = interests_one.zip(interests_two).flat_map { |f, s| f & s }.count
      ((common_interests.to_f / total_interests) * 100).round
    end
    
    # match percent based non-interests attributes
    def match_profile
      points = 0
      points += 5 if profile_one.occupation == profile_two.occupation
      points +=10 if profile_one.religion == profile_two.religion
      points +=10 if profile_one.smoke == profile_two.smoke
      points +=10 if profile_one.drink == profile_two.drink
      points +=10 if profile_one.drugs == profile_two.drugs
      points +=10 if profile_one.diet == profile_two.diet
      points +=25 if profile_one.looking_for == profile_two.looking_for
      points += match_age
      points -= match_education
      if points < 0
        return 0
      else
        return points
      end
    end
    
    # Gets difference in education level
    def match_education
      if profile_one.edu_num >= profile_two.edu_num
        profile_one.edu_num - profile_two.edu_num
      else
        profile_two.edu_num - profile_one.edu_num
      end
    end
    
    # Matches based on age preferences of both users
    def match_age
      points = 0
      points += 10 if profile_one.age_range.include? profile_two.age
      points += 10 if profile_two.age_range.include? profile_one.age
      points
    end
  
end
