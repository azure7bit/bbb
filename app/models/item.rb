class Item < ActiveRecord::Base
  attr_accessible :code, :name, :stock, :color, :is_active, :ci_number, :category_id, :name_alias

  belongs_to :category

  has_many :supplier_items
  has_many :suppliers, :through => :supplier_items
  has_many :purchase_orders, :through => :purchase_order_details
  has_many :po_receive_details
  has_many :sales_invoice_details
  has_many :customer_item_prices
  has_many :manage_stocks

  delegate :name, :unit, :to => :category, :prefix => true

  before_save :total_item
  before_save :set_name_alias
  before_save :set_item_code if :new_record?

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

  def self.find_next_available_number_for(default=99999)
    self.any? ? (self.maximum(:code, :order => "code") || default).succ : "IT-00001"
  end

  def critical
    if self.stock
      (self.stock < 1) ? "Critical" : "Normal"
    else
      "Critical"
    end
  end

  def items_out
    self.sales_invoice_details.sum(:qty)
  end

  def price
    item = self.customer_item_prices.last
    item ? item.price : 0
  end

  def self.stock_by_item
    joins(:supplier_items)
    .joins(:category)
    .where("items.is_active = ?", true)
    .select("items.id, items.code, items.ci_number, items.name, categories.name as item_category, sum(supplier_items.stock) as stock, items.color, items.is_active")
    .group("items.id, items.code, items.ci_number, items.name, categories.name, items.color, items.is_active")
  end

  def json_item(option={})
    if option.present?
      {
        :item_id => self.id,
        :item_name => self.name,
        :category_name => self.category_name,
        :item_price => self.item_by_supplier(option),
        :valas_price => self.item_by_supplier(option) * Company.first.kurs
      }
    else
      {
        :item_id => self.id,
        :item_name => self.name,
        :category_name => self.category_name,
        :item_price => self.customer_item_prices.last.nil? ? 0 : self.customer_item_prices.last.price,
        :valas_price => self.customer_item_prices.last.nil? ? 0 : self.customer_item_prices.last.price * Company.first.kurs,
        :item_stock => self.stock
      }
    end
  end

  def item_by_supplier(supplier)
    price = self.supplier_items.where(:supplier_id => supplier).last.next_price
    price ? price : 0
  end

  def self.report_items(from, to, type)
    if type=="out"
      joins(:sales_invoice_details => :sales_invoice).where("transaction_date between ? and ?", from, to)
    else
      joins(:po_receive_details => :po_receive).where("transaction_date between ? and ?", from, to)
    end
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

    def set_item_code
      self.code = Item.find_next_available_number_for
    end

end