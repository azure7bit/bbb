class PurchaseOrder < ActiveRecord::Base
  attr_accessible :po_number, :transaction_date, :po_date, :spph_number, :spph_date, 
    :deadline, :term_of_payment, :remarks, :status, :po_type, :supplier_id
  attr_accessible :purchase_order_details_attributes, :items_attributes

  belongs_to :supplier
  belongs_to :user
  has_many :purchase_order_details
  has_many :items, :through => :purchase_order_details
  
  before_save :set_status

  delegate :full_name, to: :supplier, prefix: true
  delegate :full_name, to: :user, prefix: true

  validates :po_number, presence: true, uniqueness: true
  validates :po_date, presence: true
  validates :spph_number, presence: true
  validates :spph_date, presence: true
  validates :supplier_id, presence: true
  validates :remarks, presence: true
  validates :item_ids, presence: true
  validate :item_ids_cannot_be_duplicated
  validate :item_qtys_must_be_greater_than_zero

  def self.find_next_available_number_for(default=999)
    if self.any?
      (self.maximum(:po_number, 
        :conditions => ["extract(year from po_date) = '?' AND extract(month from po_date) = ?",
          Date.today.year, Date.today.strftime('%m')],
          :order => "po_date") || default).succ
    else
      "PO/#{Date.today.strftime("%Y-%m-%d")}/0001"
    end
  end

  def set_status
    self.status = 'ordered'
  end

  def total_amount
    self.purchase_order_details.sum(:subtotal)
  end

  def total_ppn
    self.purchase_order_details.sum(:subtotal) * 0.1
  end

  def grand_total
    self.total_amount + self.total_ppn
  end

  # validate duplicate of items
  def item_ids_cannot_be_duplicated
    errors.add(:item_ids, "can't be duplicated") if item_ids.size > item_ids.uniq.size
  end

  # validates schedule dates, first check if all hash empty, if pass check hash if according to the selected stores
  def item_qtys_must_be_greater_than_zero
    if item_qtys.any? {|k,v|v.to_i <= 0}
      errors.add(:item_qtys, "must be greater than 0")
      return
    end
  end
end