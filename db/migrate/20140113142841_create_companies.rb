class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :city
      t.string :npwp
      t.float :kurs
      t.timestamps
    end
  end
end