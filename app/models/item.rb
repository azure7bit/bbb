class Item < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :supplier_items
  has_many :suppliers, :through => :supplier_items

  delegate :name, :to => :category, :prefix => true
end
