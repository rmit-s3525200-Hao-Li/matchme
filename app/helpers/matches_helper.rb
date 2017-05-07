module MatchesHelper
  
  def get_match_percent(user, matches)
    match = matches.find_by('user_one_id = ? OR user_two_id = ?', user.id, user.id)
    match.percent
  end
  
end
