class Supplier < ActiveRecord::Base
  # include ActAsCountable
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  attr_accessible :code, :first_name, :last_name, :address, :phone_number, :is_active, :supplier_items_attributes, :city

  has_many :supplier_items
  has_many :items, :through => :supplier_items
  has_many :purchase_orders

  accepts_nested_attributes_for :supplier_items, :allow_destroy => true, :reject_if => lambda { |attrs| attrs.all? { |key, value| value.blank? } }

  validates :code, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality:true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def status
    self.is_active ? 'Active' : 'Banned'
  end

  def deactive
    self.update_attributes(:is_active => false)
  end

  def activate
    self.update_attributes(:is_active => true)
  end

  def self.find_next_available_number_for(default=99999)
    self.any? ? (self.maximum(:code, :order => "code") || default).succ : "SP-00001"
  end

  def full_id
    self.code + " | " + self.full_name
  end

  def self.list_all(user)
    user.is_admin? ? order(:code) : where(:is_active => true).order(:code)
  end

  def self.list_active(default=true)
    where(:is_active => default).order(:code)
  end
end