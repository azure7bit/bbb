class TypeAccount < ActiveRecord::Base
  attr_accessible :name

  has_many :rek_accounts
end