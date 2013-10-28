class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :id_card, :first_name, :last_name, :role_id, 
                  :is_active, :date_registered
  
  belongs_to :role, :class_name => 'Role', :foreign_key => 'role_id'

  delegate :name, to: :role, prefix: true

  before_save :user_date_registered

  def user_date_registered
    self.date_registered = DateTime.now
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def member_status
    self.is_active ? 'Active' : 'Banned'
  end

end
