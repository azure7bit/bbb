class Statistic < ActiveRecord::Base
  attr_accessible :total_item, :total_supplier, :total_customer, :total_sales, :total_purchase

  def self.total(column)
  	first.update_attributes(column => maximum(column).succ)
  end

  def self.total_amount_po(subtotal)
  	amount = any? ? first.total_purchase : 0
  	total = amount+subtotal
  	first.update_attributes(:total_purchase => total)
  end

end