class SupplierPayment < ActiveRecord::Base
  attr_accessible :transaction_date, :invoice_number, :supplier_id, :notes, :balance_type, :amount, :user_id, :start_date, :end_date
  attr_accessor :start_date, :end_date

  belongs_to :supplier
  belongs_to :user

  validates :transaction_date, presence: true
  validates :invoice_number, presence: true
  validates :supplier_id, presence: true
  validates :amount, presence: true

  delegate :full_name, to: :supplier, prefix: true, allow_nil: true

  after_save :update_transaction if :new_record?

  def self.generate_balance(supplier_id, from, to)
    start = from.to_date.strftime("%Y-%m-%d 00:00:00")
    finish = to.to_date.strftime("%Y-%m-%d 23:59:59")

    initial_credit = SupplierPayment.where(:supplier_id => supplier_id, :balance_type => "credit").where("transaction_date < ?", start).sum(:amount)
    initial_debit = SupplierPayment.where(:supplier_id => supplier_id, :balance_type => "debit").where("transaction_date < ?", start).sum(:amount)
    initial_balance = initial_credit -  initial_debit

    transactions = SupplierPayment.where(:supplier_id => supplier_id).where(:transaction_date => start..finish).order(:transaction_date)

    supplier_payments = Array.new
    balance = initial_balance

    transactions.each do |trans|
      trans.balance_type == "credit" ? balance += trans.amount : balance -= trans.amount
      supplier_payments.push(
        :transaction_date => trans.transaction_date.strftime("%d %B %Y"),
        :invoice_number => trans.invoice_number,
        :supplier => trans.supplier.full_name,
        :notes => trans.notes,
        :balance_type => trans.balance_type,
        :amount => trans.amount,
        :balance => balance
        )
    end
    return supplier_payments
  end

  def self.find_next_available_number_for(option={}, default=999)
    year = option[:date] ? Date.parse(option[:date]).year : Date.today.year
    month = option[:date] ? Date.parse(option[:date]).month : Date.today.strftime('%m')
    tanggal = option[:date] ? Date.parse(option[:date]).strftime("%Y-%m") : Date.today.strftime("%Y-%m")
    if self.any?
      max_number = maximum(:invoice_number, :conditions => ["extract(year from transaction_date) = ? AND extract(month from transaction_date) = ? AND invoice_number LIKE 'SPY%'", year, month], :order => "transaction_date")
      max_number ? (max_number || default).succ : "SPY/#{tanggal}/0001"
    else
      "SPY/#{tanggal}/0001"
    end
  end

  private
    def update_transaction
      #pembelian
      account_id = RekAccount.where(name: "Hutang").first
      param_trans = {
        :saldo => self.amount,
        :currency_type => false,
        :posisi => 'Kredit',
        :from_transaction => 'Hutang barang supplier',
        :name => "Hutang barang dari #{self.supplier_full_name}",
        :description => "Hutang barang"
      }
      account_id.transactions.build(param_trans).save
    end
end