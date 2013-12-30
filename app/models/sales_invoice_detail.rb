class SalesInvoiceDetail < ActiveRecord::Base
  attr_accessible :qty, :subtotal, :item_id

  belongs_to :item
  belongs_to :sales_invoice

  after_save :total_sales_statistic

  def self.total_sales_orders
    sum(:subtotal)
  end

  def total_sales_statistic
    stat = Statistic.first
    total_sales = stat.total_sales.nil? ? 0 : (stat.total_sales + SalesInvoiceDetail.total_sales_orders)
    stat.update_attributes(:total_sales => total_sales)
  end
end
