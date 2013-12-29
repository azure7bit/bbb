class SalesInvoice < ActiveRecord::Base
  attr_accessible :invoice_number, :transaction_date, :payment, :npwp, :ppn, :supplier_items_attributes, :items

  belongs_to :customer
  belongs_to :user
  
  has_many :sales_invoice_details
  has_many :items, :through => :sales_invoice_details
  
  accepts_nested_attributes_for :sales_invoice_details, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :items, :reject_if => :all_blank

  def self.find_next_available_number_for(customer, default=999)
    if self.any?
      (customer.sales_invoices.maximum(:invoice_number, 
        :conditions => ["extract(year from transaction_date) = '?' AND extract(month from transaction_date) = ?",
          Date.today.year, Date.today.strftime('%m')],
          :order => "transaction_date") || default).succ
    else
      "INV/#{Date.today.strftime("%Y-%m-%d")}/0001"
    end
  end

  def total_sales_orders
    self.sales_invoice_details.summ(:subtotal)
  end
end