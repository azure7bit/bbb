module UsersHelper
  def format_phone(phone, mobile=false)
    number_to_phone(phone, country_code: 62)
  end
end