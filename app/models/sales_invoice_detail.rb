class SalesInvoiceDetail < ActiveRecord::Base
  attr_accessible :qty, :subtotal

  belongs_to :item
  belongs_to :sales_invoice
end
