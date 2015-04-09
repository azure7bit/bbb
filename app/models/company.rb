class Company < ActiveRecord::Base
  attr_accessible :name, :address, :phone, :email, :city, :npwp, :kurs
end