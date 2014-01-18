class SalesInvoiceDetail < ActiveRecord::Base
  attr_accessible :qty, :subtotal, :item_id

  belongs_to :item
  belongs_to :sales_invoice

  before_save :update_stock
  after_save :total_sales_statistic

  delegate :name, :retail_price, to: :item, :prefix => true

  def self.total_sales_orders
    sum(:subtotal)
  end

  private

    def update_stock
      newStock = self.item.stock - self.qty
      self.item.update_attributes(:stock => newStock)
    end

    def total_sales_statistic
      stat = Statistic.first
      total_sales = stat.total_sales.nil? ? 0 : (stat.total_sales + SalesInvoiceDetail.total_sales_orders)
      stat.update_attributes(:total_sales => total_sales)
    end
end