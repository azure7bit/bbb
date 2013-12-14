class Customer < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  
  attr_accessible :code, :first_name, :last_name, :address, :phone_number

  validates :code, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality:true

  has_many :sales_invoices

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
