class PurchaseOrder < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :supplier_address, :supplier_city
  belongs_to :supplier
end