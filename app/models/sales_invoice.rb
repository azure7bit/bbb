class SalesInvoice < ActiveRecord::Base
  attr_accessible :invoice_number, :transaction_date, :payment, :npwp, :ppn,
    :customer_id, :total, :grand_total, :kurs, :user_id, :discount, :down_payment, :currency_type
  attr_accessible :sales_invoice_details_attributes, :items_attributes

  attr_accessor :total, :grand_total

  belongs_to :customer
  belongs_to :user

  has_many :sales_invoice_details
  has_many :items, :through => :sales_invoice_details

  accepts_nested_attributes_for :sales_invoice_details, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :items, :reject_if => :all_blank

  validates_associated :sales_invoice_details
  validates_associated :items

  validates :invoice_number, :presence => true
  validates :transaction_date, presence: true
  validates :customer_id, presence: true

  delegate :full_name, :address, :phone_number, :npwp, :to => :customer, :prefix => true

  after_save :update_transaction if :new_record?

  def self.find_next_available_number_for(option={}, default=999)
    year = option[:date] ? Date.parse(option[:date]).year : Date.today.year
    month = option[:date] ? Date.parse(option[:date]).month : Date.today.strftime('%m')
    tanggal = option[:date] ? Date.parse(option[:date]).strftime("%Y-%m") : Date.today.strftime("%Y-%m")
    if self.any?
      max_number = maximum(:invoice_number, :conditions => ["extract(year from transaction_date) = ? AND extract(month from transaction_date) = ?", year, month], :order => "po_date")
      max_number ? (max_number || default).succ : "INV/#{tanggal}/0001"
    else
      "INV/#{tanggal}/0001"
    end
  end

  def total_sales_orders
    self.sales_invoice_details.sum(:subtotal)
  end

  def self.history_order
    joins(:sales_invoice_details).group(:transaction_date).sum(:subtotal).to_a
  end

  def total_ppn
    self.sales_invoice_details.sum(:subtotal) * 0.1
  end

  def grand_total
    (self.total_sales_orders.to_f + self.total_ppn.to_f)
  end

  def self.stock_not_updated
    joins(:sales_invoice_details)
  end

  private
    def update_transaction
      #penjualan
      account_id = RekAccount.where(name: "Penjualan").first
      param_trans = {
        :saldo => self.sales_invoice_details.sum(:subtotal),
        :currency_type => self.currency_type,
        :posisi => 'Debit',
        :from_transaction => 'Penjualan barang untuk customer',
        :name => "Penjualan barang dari #{self.customer_full_name}",
        :description => "Penjualan barang"
      }
      account_id.transactions.build(param_trans).save
    end
end
