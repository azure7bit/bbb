class SalesInvoice < ActiveRecord::Base
  attr_accessible :invoice_number, :transaction_date, :payment, :npwp, :ppn

  belongs_to :customer
  belongs_to :user
 
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
end