after :suppliers do
  puts "======== Seeding AMC Supplier Items Data ========="
  amc = Supplier.find 2

  items = Item.all
  items.each do |item|
    temp = {:item_id => item.id, :date_price => Date.today, :price => 10, :next_price => 15, :stock => 10}
    amc.supplier_items.build(temp).save
  end
end