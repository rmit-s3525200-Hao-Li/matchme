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
  def display_thumbnail(user)
    unless user.picture.nil?
      image_tag(user.picture.thumb.url)
    else
      image_tag(default_url)
    end
  end
  
  # Display profile attributes
  def display_attribute(key, attribute)
    if !attribute.blank?
      puts "<dt>#{key}</dt>"
      puts "<dt>#{attribute}</dt>"
    end
  end
  
end
