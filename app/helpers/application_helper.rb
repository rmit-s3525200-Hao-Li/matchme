module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "MatchMe"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  # Displays default thumbnail unless user has uploaded picture
  def display_thumbnail(profile)
    unless profile.picture.nil?
      image_tag(profile.picture.thumb.url)
    else
      image_tag(default_url)
    end
  end
  
  # Check if user has match
  def has_match?(user, matches)
    match = matches.find_by('user_one_id = ? OR user_two_id = ?', user.id, user.id)
    !match.nil?
  end
  
  # Get match percent
  def get_match_percent(user, matches)
    match = matches.find_by('user_one_id = ? OR user_two_id = ?', user.id, user.id)
    if !match.nil?
      match.percent
    end
  end
  
end
