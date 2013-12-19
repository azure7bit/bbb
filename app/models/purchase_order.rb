class PurchaseOrder < ActiveRecord::Base
  attr_accessible :po_number, :transaction_date, :po_date, :spph_number, :spph_date, 
  :deadline, :term_of_payment, :remarks, :status, :po_type
  attr_accessor :supplier_address, :supplier_city
  belongs_to :supplier

  def self.find_next_available_number_for(default=999)
    if self.any?
      (self.maximum(:po_number, 
        :conditions => ["extract(year from po_date) = '?' AND extract(month from po_date) = ?",
          Date.today.year, Date.today.strftime('%m')],
          :order => "po_date") || default).succ
    else
      "PO/#{Date.today.strftime("%Y-%m-%d")}/0001"
    end
  end
end