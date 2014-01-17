class SalesInvoice < ActiveRecord::Base
  attr_accessible :invoice_number, :transaction_date, :payment, :npwp, :ppn, 
    :customer_id, :total, :grand_total, :kurs, :user_id, :discount, :down_payment
  attr_accessible :sales_invoice_details_attributes, :items_attributes

  attr_accessor :total, :grand_total

  belongs_to :customer
  belongs_to :user
  
  has_many :sales_invoice_details
  has_many :items, :through => :sales_invoice_details
  
  accepts_nested_attributes_for :sales_invoice_details, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :items, :reject_if => :all_blank

  validates_associated :sales_invoice_details
  validates_associated :items

  validates :invoice_number, :presence => true
  validates :transaction_date, presence: true
  validates :customer_id, presence: true

  delegate :full_name, :to => :customer, :prefix => true
  
  # def self.find_next_available_number_for(default=999)
  #   if any?
  #     (maximum(:invoice_number, 
  #       :conditions => ["extract(year from transaction_date) = '?' AND extract(month from transaction_date) = ?",
  #         Date.today.year, Date.today.strftime('%m')],
  #         :order => "transaction_date") || default).succ
  #   else
  #     "INV/#{Date.today.strftime("%Y-%m-%d")}/0001"
  #   end
  # end

  def self.find_next_available_number_for(option={}, default=999)
    year = option[:date] ? Date.parse(option[:date]).year : Date.today.year
    month = option[:date] ? Date.parse(option[:date]).month : Date.today.strftime('%m')
    if self.any?
      max_number = maximum(:invoice_number, :conditions => ["extract(year from transaction_date) = ? AND extract(month from transaction_date) = ?", year, month], :order => "po_date")
      max_number ? (max_number || default).succ : "INV/#{Date.parse(option[:date]).strftime("%Y-%m")}/0001"
    else
      "INV/#{Date.today.strftime("%Y-%m")}/0001"
    end
  end

  def total_sales_orders
    self.sales_invoice_details.sum(:subtotal)
  end

  def self.history_order
    joins(:sales_invoice_details).group(:transaction_date).sum(:subtotal).to_a
  end
end