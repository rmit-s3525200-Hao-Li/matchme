module MatchesHelper
  
  def has_match?(user, matches)
    match = matches.find_by('user_one_id = ? OR user_two_id = ?', user.id, user.id)
    !match.nil?
  end
  
  def get_match_percent(user, matches)
    match = matches.find_by('user_one_id = ? OR user_two_id = ?', user.id, user.id)
    if !match.nil?
      match.percent
    end
  end
  
end
