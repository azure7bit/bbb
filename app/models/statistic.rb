class Statistic < ActiveRecord::Base 
  attr_accessible :total_item, :total_supplier, :total_customer, :total_sales, :total_purchase, :total_critical_items

  def self.total(column)
  	first.update_attributes(column => maximum(column).succ)
  end
end