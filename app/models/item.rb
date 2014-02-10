class Item < ActiveRecord::Base
  attr_accessible :code, :name, :stock, :color, :is_active, :ci_number, :category_id, :name_alias

  belongs_to :category

  has_many :supplier_items
  has_many :suppliers, :through => :supplier_items
  has_many :purchase_orders, :through => :purchase_order_details
  has_many :po_receive_details
  has_many :sales_invoice_details
  has_many :customer_item_prices

  delegate :name, :unit, :to => :category, :prefix => true
  
  before_save :total_item
  before_save :set_name_alias

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
    minimumStock = self.stock ? self.stock : 0
    (self.stock < (minimumStock + 1)) ? "Critical" : "Normal"
  end

  def items_in
    self.po_receive_details.sum(:qty)
  end

  def items_out
    self.sales_invoice_details.sum(:qty)
  end

  def self.stock_by_item
    joins(:supplier_items)
    .joins(:category)
    .where("items.is_active = ?", true)
    .select("items.id, items.code, items.ci_number, items.name, categories.name as item_category, sum(supplier_items.stock) as stock, items.color, items.is_active")
    .group("items.id, items.code, items.ci_number, items.name, categories.name, items.color, items.is_active")
  end

  def item_by_supplier(supplier)
    price = self.supplier_items.where(:supplier_id => supplier).last.next_price
    price ? price : 0
  end

  private
    def set_name_alias
      self.name_alias = self.name_alias ? self.name_alias : self.name
    end

    def total_item
      Statistic.total(:total_item)
    end

    def total_critical
      item_critical = Item.all.map(&:critical).count("Critical")
      Statistic.first.update_attributes(:total_critical_items => item_critical)
    end

end