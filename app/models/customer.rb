class Customer < ActiveRecord::Base
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  attr_accessible :code, :first_name, :last_name, :address, :phone_number, :is_active, :ppn_charge, :npwp, :customer_item_prices_attributes

  validates :code, uniqueness: true

  has_many :sales_invoices
  has_many :sales_invoice_details, :through => :sales_invoices
  has_many :customer_item_prices
  has_many :customer_payments

  accepts_nested_attributes_for :customer_item_prices, :allow_destroy => true
  before_save :total_customer
  before_save :set_customer_code if :new_record?

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

  def total_pay_for_orders
    self.sales_invoice_details.sum(:subtotal)
  end

  private
    def total_customer
      Statistic.total(:total_customer)
    end

    def set_customer_code
      self.code = Customer.find_next_available_number_for
    end
end