class Item < ActiveRecord::Base
  attr_accessible :code, :name, :retail_price, :stock, :color, :is_active, :ci_number, :category_id, :minimum_stock

  belongs_to :category

  has_many :supplier_items
  has_many :suppliers, :through => :supplier_items
  has_many :purchase_orders, :through => :purchase_order_details

  delegate :name, :unit, :to => :category, :prefix => true
  
  before_save :total_item

  after_save :total_critical
  
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

  def critical
    minimumStock = self.minimum_stock ? self.minimum_stock : 0
    (self.stock < (minimumStock + 1)) ? "Critical" : "Normal"
  end

  private
    def total_item
      Statistic.total(:total_item)
    end

    def total_critical
      item_critical = Item.all.map(&:critical).count("Critical")
      Statistic.first.update_attributes(:total_critical_items => item_critical)
    end

end