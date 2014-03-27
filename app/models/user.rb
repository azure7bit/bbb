class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :id_card, :first_name, :last_name, 
                  :is_active, :date_registered, :phone_number, :address, :avatar

  mount_uploader :avatar, AvatarUploader

  validate :valid_password, :on => :update

  belongs_to :role, :class_name => 'Role', :foreign_key => 'role_id'
  has_many :purchase_orders
  has_many :receives_po, :class_name => 'PoReceive', :foreign_key => 'user_id'
  has_many :sales_invoices

  delegate :name, to: :role, prefix: true

  before_save :user_date_registered
  before_update :valid_password

  def since
    Date.parse(self.date_registered.to_s)
  end

  def user_date_registered
    self.date_registered = DateTime.now if self.new_record?
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def member_status
    self.is_active ? 'Active' : 'Banned'
  end

  def is_admin?
    self.role_id == 1
  end

  def is_sales?
    self.role_id == 2
  end

  def is_purchase?
    self.role_id == 3
  end

  def self.account_member
    where("role_id > 1")
  end

  def deactive
    self.update_attributes(:is_active => false)
  end

  def activate
    self.update_attributes(:is_active => true)
  end

private
  def valid_password
    if self.password.present?
      errors.add(:password, "Password and password_confirmation no match") unless self.password == self.password_confirmation
    end
  end

  def self.find_for_authentication(conditions)
    conditions[:is_active] = true
    find(:first, conditions: conditions)
  end

end