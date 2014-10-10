class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :code
      t.string :name
      t.string :unit      
    end
  end
end
