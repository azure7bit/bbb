class CustomerPayment < ActiveRecord::Base
  attr_accessible :transaction_date, :invoice_number, :customer_id, :notes, :balance_type, :amount, :user_id, :start_date, :end_date
  attr_accessor :start_date, :end_date

  belongs_to :customer
  belongs_to :user

  validates :transaction_date, presence: true
  validates :invoice_number, presence: true
  validates :customer_id, presence: true
  validates :amount, presence: true

  def self.generate_balance(customer_id, from, to)
    start = from.to_date.strftime("%Y-%m-%d 00:00:00")
    finish = to.to_date.strftime("%Y-%m-%d 23:59:59")
    
    initial_credit = CustomerPayment.where(:customer_id => customer_id).where(:balance_type => "credit").where("transaction_date < ?", start).sum(:amount)
    initial_debit = CustomerPayment.where(:customer_id => customer_id).where(:balance_type => "debit").where("transaction_date < ?", start).sum(:amount)
    initial_balance = initial_credit -  initial_debit

    transactions = CustomerPayment.where(:customer_id => customer_id).where(:transaction_date => start..finish).order(:transaction_date)
    
    customer_payments = Array.new  
    balance = initial_balance
    
    transactions.each do |trans|
      trans.balance_type == "credit" ? balance += trans.amount : balance -= trans.amount
      customer_payments.push(
        :transaction_date => trans.transaction_date.strftime("%d %B %Y"),
        :invoice_number => trans.invoice_number,
        :customer => trans.customer.full_name,
        :notes => trans.notes,
        :balance_type => trans.balance_type,
        :amount => trans.amount,
        :balance => balance
        )
    end
    return customer_payments
  end

  def self.find_next_available_number_for(option={}, default=999)
    year = option[:date] ? Date.parse(option[:date]).year : Date.today.year
    month = option[:date] ? Date.parse(option[:date]).month : Date.today.strftime('%m')
    tanggal = option[:date] ? Date.parse(option[:date]).strftime("%Y-%m") : Date.today.strftime("%Y-%m")
    if self.any?
      max_number = maximum(:invoice_number, :conditions => ["extract(year from transaction_date) = ? AND extract(month from transaction_date) = ? AND invoice_number ILIKE 'CPY%'", year, month], :order => "transaction_date")
      max_number ? (max_number || default).succ : "CPY/#{tanggal}/0001"
    else
      "CPY/#{tanggal}/0001"
    end
  end
end