class Supplier < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  attr_accessible :code, :first_name, :last_name, :address, :phone_number

  has_many :supplier_items
  has_many :items, :through => :supplier_items

  accepts_nested_attributes_for :supplier_items, :allow_destroy => true, :reject_if => lambda { |attrs| attrs.all? { |key, value| value.blank? } }

  validates :code, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality:true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end