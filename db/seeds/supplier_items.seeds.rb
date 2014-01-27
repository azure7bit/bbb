after :suppliers do
  puts "======== Seeding AMC Supplier Items Data ========="
  amc = Supplier.find 2

  items = Item.all
  items.each do |item|
    temp = {:item_id => item.id}
    amc.supplier_items.build(temp).save
  end
end