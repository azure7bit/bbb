class PoReceive < ActiveRecord::Base
  attr_accessible :purchase_order_id, :invoice_number, :transaction_date, :status, :user_id, :kurs, 
    :ppn, :total, :grand_total, :total_valas, :grand_total_valas, :ppn_valas, :po_number, :po_date, 
    :supplier_id, :item_id, :qty, :subtotal
  attr_accessible :po_receive_details_attributes, :items_attributes

  attr_accessor :total, :grand_total, :total_valas, :grand_total_valas, :ppn_valas, :po_number, 
    :po_date, :item_id, :qty, :subtotal

  belongs_to :purchase_order
  belongs_to :supplier
  belongs_to :user

  has_many :po_receive_details
  has_many :items, :through => :po_receive_details

  delegate :full_name, :full_id, :address, :city, :contact_person, :phone_number, to: :supplier, prefix: true
  delegate :full_name, to: :user, prefix: true
  
  accepts_nested_attributes_for :po_receive_details, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :items

  after_save :update_po, :total_purchase_statistic, :grand_total

  def self.find_next_available_number_for(default=999)
    if self.any?
      (self.maximum(:invoice_number, 
        :conditions => ["extract(year from transaction_date) = '?' AND extract(month from transaction_date) = ?",
          Date.today.year, Date.today.strftime('%m')],
          :order => "transaction_date") || default).succ
    else
      "PR/#{Date.today.strftime("%Y-%m-%d")}/0001"
    end
  end

  def total_amount
    self.po_receive_details.sum(:subtotal)
  end

  def self.history_order
    joins(:po_receive_details => {:item => :suppliers}).group(:transaction_date).sum(:subtotal).to_a
  end

  def grand_total_amount
    total_amount + self.ppn
  end

  private

    def grand_total
      stat = Statistic.first
      stat.update_attributes(:total_purchase => PoReceive.joins(:po_receive_details => {:item => :suppliers}).sum(:subtotal))
    end

    def total_purchase_statistic
      stat = Statistic.first
      total_purchase = stat.total_purchase.nil? ? 0 : (stat.total_purchase + PoReceiveDetail.total_purchase_orders)
      stat.update_attributes(:total_purchase => total_purchase)
    end

    def update_po
      self.purchase_order.update_attributes!(:status => "closed")
    end
end
