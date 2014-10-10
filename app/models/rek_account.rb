class RekAccount < ActiveRecord::Base
  attr_accessible :number, :name, :type_account_id, :parent_id, :tanggal_awal, :awal_debit, :awal_kredit, :mut_debit, :mut_kredit, :sisa_debit,
  :sisa_kredit, :rl_debit, :rl_kredit, :nrc_debit, :nrc_kredit, :posisi, :normal

  belongs_to :parent_account, :class_name => "RekAccount", :foreign_key => :parent_id
  belongs_to :type_account

  has_many :child_accounts, :class_name => "RekAccount", :foreign_key => :parent_id

  after_save :setup_number_of_account

  def setup_number_of_account
    self.number = "#{self.type_account_id}.#{self.number}"
  end

end