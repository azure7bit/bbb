class TransactionsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@transaction_dollar = Transaction.where(currency_type: true)
		@transaction_rupiah = Transaction.where(currency_type: false)
	end
end