class PoReceive < ActiveRecord::Base
  attr_accessible :purchase_order_id, :invoice_number, :transaction_date, :status, :user_id, :kurs, :ppn, :supplier_id

  belongs_to :purchase_order_id
  belongs_to :supplier
  belongs_to :user
  has_many :po_receive_details
  has_many :items, :through => :purchase_receive_details
  
  accepts_nested_attributes_for :purchase_receive_details, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :items

  before_save :update_stock

  after_save :total_purchase_statistic
  after_save :grand_total

  private

    def grand_total
      stat = Statistic.first
      stat.update_attributes(:total_purchase => PoReceive.joins(:po_receive_details => {:item => :suppliers}).sum(:subtotal))
    end

    def update_stock
      newStock = self.item.stock + self.qty
      self.item.update_attributes(:stock => newStock)
    end

    def total_purchase_statistic
      stat = Statistic.first
      total_purchase = stat.total_purchase.nil? ? 0 : (stat.total_purchase + PoReceiveDetail.total_purchase_orders)
      stat.update_attributes(:total_purchase => total_purchase)
    end
end
