class PurchaseOrder < ActiveRecord::Base
  attr_accessible :po_number, :transaction_date, :po_date, :spph_number, :spph_date, 
    :deadline, :term_of_payment, :remarks, :status, :po_type, :supplier_id, :item_ids, :item_qtys, :item_notes, :item_prices
  attr_accessor :supplier_address, :supplier_city, :total, :ppn, :grand_total, :item_ids, :item_qtys, :item_notes, :item_prices

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
end