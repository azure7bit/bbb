puts "======== Seeding Supplier Items Data ========="
SupplierItem.create!([
{ :supplier_id=>1, :item_id=>1, :purchase_price=>10 },
{ :supplier_id=>2, :item_id=>2, :purchase_price=>12 },
{ :supplier_id=>2, :item_id=>3, :purchase_price=>14 },
{ :supplier_id=>2, :item_id=>4, :purchase_price=>15 }
])