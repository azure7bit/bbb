class PurchaseOrder < ActiveRecord::Base
  attr_accessible :po_number, :po_date, :remarks, :status, :supplier_id, :user_id, :currency_type
  attr_accessible :purchase_order_details_attributes, :items_attributes, :kurs

  attr_accessor :kurs

  belongs_to :supplier
  belongs_to :user
  has_many :purchase_order_details
  has_many :items, :through => :purchase_order_details
  
  accepts_nested_attributes_for :purchase_order_details, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :items

  before_save :set_status

  delegate :full_name, :full_id, :address, :city, :contact_person, :phone_number, to: :supplier, prefix: true
  delegate :full_name, to: :user, prefix: true

  validates :po_number, :presence => true
  validates :po_date, presence: true
  validates :supplier_id, presence: true

  validates_associated :purchase_order_details

  def self.find_next_available_number_for(option={}, default=999)
    year = option[:date] ? Date.parse(option[:date]).year : Date.today.year
    month = option[:date] ? Date.parse(option[:date]).month : Date.today.strftime('%m')
    tanggal = option[:date] ? Date.parse(option[:date]).strftime("%Y-%m") : Date.today.strftime("%Y-%m")
    if self.any?
      max_number = maximum(:po_number, :conditions => ["extract(year from po_date) = ? AND extract(month from po_date) = ?", year, month], :order => "po_date")
      max_number ? (max_number || default).succ : "PO/#{tanggal}/0001"
    else
      "PO/#{tanggal}/0001"
    end
  end

  def set_status
    self.status = 'ordered' if self.new_record?
  end

  def total_amount
    self.purchase_order_details.sum(:subtotal)
  end

  def total_ppn
    self.purchase_order_details.sum(:subtotal) * 0.1
  end

  def closed?
    self.status.eql?("closed")
  end

  def grand_total
    self.total_amount + self.total_ppn
  end
end