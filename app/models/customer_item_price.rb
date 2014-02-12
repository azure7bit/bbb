class CustomerItemPrice < ActiveRecord::Base
  attr_accessible :customer_id, :item_id, :price, :date_price, :next_price, :item_name

  attr_accessor :item_name

  belongs_to :customer
  belongs_to :item

  delegate :name, :to => :item, :prefix => true
end
