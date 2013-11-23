class Role < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  def filtering_user(user_id)
  	self.users.find_by_id(user_id)
  end
end
