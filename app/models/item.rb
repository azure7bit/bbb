class Item < ActiveRecord::Base
  attr_accessible :code, :name, :retail_price, :stock, :color, :is_active, :ci_number, :category_id

  belongs_to :category

  has_many :supplier_items
  has_many :suppliers, :through => :supplier_items
  has_many :purchase_orders, :through => :purchase_order_details

  delegate :name, :unit, :to => :category, :prefix => true
  
  before_save :total_item
  
  def status
    self.is_active ? 'Active' : 'Banned'
  end

  def deactive
    self.update_attributes(:is_active => false)
  end

  def activate
    self.update_attributes(:is_active => true)
  end

  def self.find_next_available_number_for(category, default=99999)
    self.any? ? (category.items.maximum(:code, :order => "code") || default).succ : "IT-00001"
  end

  private
    def total_item
      Statistic.total(:total_item)
    end
end