class Transaction < ActiveRecord::Base
  attr_accessible :rek_account_id, :saldo, :currency_type, :posisi, :from_transaction, :name, :description

  belongs_to :rek_account
  delegate :name, to: :rek_account, prefix: true, allow_nil: true
end