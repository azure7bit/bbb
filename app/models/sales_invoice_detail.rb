class SalesInvoiceDetail < ActiveRecord::Base
  attr_accessible :qty, :subtotal, :item_id, :price, :stock_updated, :order_name
  attr_accessor :order_name
  
  belongs_to :item
  belongs_to :sales_invoice

  before_save :update_stock
  before_save :set_subtotals
  after_save :total_sales_statistic, :update_price_tag

  delegate :name, :code, to: :item, :prefix => true
  delegate :invoice_number, to: :sales_invoice, :prefix => true

  def self.total_sales_orders
    sum(:subtotal)
  end

  def retail_price
    self.price ? self.price : 0
  end

  private

    def update_stock
      newStock = self.item.stock - self.qty
      self.item.update_attributes(:stock => newStock)
    end

    def total_sales_statistic
      if self.new_record?
        stat = Statistic.first
        total_sales = stat.total_sales.nil? ? 0 : (stat.total_sales + SalesInvoiceDetail.total_sales_orders)
        stat.update_attributes(:total_sales => total_sales)
      end
    end

    def set_subtotals
      self.subtotal = self.qty * self.price
    end

    def update_price_tag
      item_price = self.item.customer_item_prices.where(:customer_id => self.sales_invoice.customer.id).last
      price_tag = {
        :customer_id => self.sales_invoice.customer.id,
        :item_id => self.item_id,
        :price => item_price ? item_price.next_price : self.price,
        :next_price => self.price
      }
      cs = CustomerItemPrice.create(price_tag)
      cs.save
    end
end
