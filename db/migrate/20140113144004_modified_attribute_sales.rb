class ModifiedAttributeSales < ActiveRecord::Migration
  def up
    remove_column :purchase_orders, :spph_number
    remove_column :purchase_orders, :spph_date
    remove_column :purchase_orders, :deadline
    remove_column :purchase_orders, :term_of_payment
    remove_column :purchase_orders, :po_type
    remove_column :supplier_items, :is_ppn
    remove_column :sales_invoices, :npwp
    add_column :sales_invoices, :kurs, :float
    add_column :sales_invoices, :discount, :float
    add_column :sales_invoices, :down_payment, :float
    add_column :customers, :npwp, :string
  end

  def down
    add_column :purchase_orders, :spph_number, :string 
    add_column :purchase_orders, :spph_date, :datetime
    add_column :purchase_orders, :deadline, :datetime
    add_column :purchase_orders, :term_of_payment, :integer
    add_column :purchase_orders, :po_type, :string
    add_column :supplier_items, :is_ppn, :boolean
    add_column :sales_invoices, :npwp, :string
    remove_column :sales_invoices, :kurs
    remove_column :sales_invoices, :discount
    remove_column :sales_invoices, :down_payment
    remove_column :customers, :npwp
  end
end