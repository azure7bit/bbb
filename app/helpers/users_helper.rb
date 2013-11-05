module UsersHelper
  def format_phone(phone, mobile=false)
    number_to_phone(phone, country_code: 62)
  end

  def status_label(user)
  	str = user.is_active ? "label-success" : "label-important"
  	return str
  end
end