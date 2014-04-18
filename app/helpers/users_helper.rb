module UsersHelper
  def format_phone(phone, mobile=false)
    number_to_phone(phone, country_code: 62)
  end

  def status_label(user)
  	str = user.is_active ? "label-success" : "label-important"
  	return str
  end

  def status_item(item)
  	str = item.critical.eql?("Critical") ? "label-important" : "label-success" 
  	return str
  end

  def img_url(default=current_user, thumbnail=:thumb)
    img_url = default.avatar.path
    img_url = File.zero?(img_url) ? "/assets/no_avatar.png" : default.avatar_url(thumbnail)
  end
end