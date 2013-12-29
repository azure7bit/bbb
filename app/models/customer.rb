class Customer < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  
  attr_accessible :code, :first_name, :last_name, :address, :phone_number, :is_active

  validates :code, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality:true

  has_many :sales_invoices

  before_save :total_customer

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
    self.any? ? (self.maximum(:code, :order => "code") || default).succ : "CS-00001"
  end

  def full_id
    self.code + " | " + self.full_name
  end

  def self.list_active
    where(:is_active => true)
  end

  private
    def total_customer
      Statistic.total(:total_customer)
    end
end