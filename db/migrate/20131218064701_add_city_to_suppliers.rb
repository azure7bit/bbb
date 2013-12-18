class AddCityToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :city, :string, :after => :address
  end
end
