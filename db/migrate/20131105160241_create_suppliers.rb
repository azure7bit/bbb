class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :code
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :phone_number
    end
  end
end
