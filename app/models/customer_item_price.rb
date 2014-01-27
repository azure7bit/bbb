class CustomerItemPrice < ActiveRecord::Base
  attr_accessible :customer_id, :item_id, :price, :date_price, :next_price

  belongs_to :customer
  belongs_to :item
end
