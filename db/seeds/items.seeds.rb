after :categories do
  puts "======== Seeding Disperse Item Data ========="
  disperse = Category.find 1
  
  items = [
    { :code=>"IT-00001", :name=>"DISPERSE RED BEL", :retail_price=>10.60, :stock=>10, :is_active => true },
    { :code=>"IT-00002", :name=>"DISPERSE RED FB", :retail_price=>10.30, :stock=>10, :is_active => true },
    { :code=>"IT-00003", :name=>"DISPERSE FLOUR PINK 2R", :retail_price=>20.50, :stock=>10, :is_active => true },
    { :code=>"IT-00004", :name=>"DISPERSE RUBINE S2GFL", :retail_price=>3.70, :stock=>10, :is_active => true },
    { :code=>"IT-00005", :name=>"DISPERSE BROWN SR", :retail_price=>5.50, :stock=>10, :is_active => true },
    { :code=>"IT-00006", :name=>"DISPERSE ORANGE 2GF", :retail_price=>5.40, :stock=>10, :is_active => true },
    { :code=>"IT-00007", :name=>"DISPERSE VIOLET S4RL", :retail_price=>12.50, :stock=>10, :is_active => true },
    { :code=>"IT-00008", :name=>"DISPERSE VIOLET 31 150%", :retail_price=>13.75, :stock=>10, :is_active => true },
    { :code=>"IT-00009", :name=>"DISPERSE TURQ BLUE SGL", :retail_price=>16.00, :stock=>10, :is_active => true },
    { :code=>"IT-00010", :name=>"DISPERSE RED F3BS", :retail_price=>18.00, :stock=>10, :is_active => true }
  ]

  items.each do |item|
    disperse.items.build(item)
    disperse.save
  end

  puts "======== Seeding Direct Item Data ========="
  direct = Category.find 2
  
  direct_items = [
    { :code=>"IT-00011", :name=>"DIRECT SUPRA ROSE FR", :retail_price=>4.60, :stock=>10, :is_active => true },
    { :code=>"IT-00012", :name=>"DIRECT SUPRA BLUE BRL", :retail_price=>6.40, :stock=>10, :is_active => true },
    { :code=>"IT-00013", :name=>"DIRECT BLUE 4BL", :retail_price=>15.00, :stock=>10, :is_active => true },
    { :code=>"IT-00014", :name=>"DIRECT LIGHT SCARLET F2G", :retail_price=>5.20, :stock=>10, :is_active => true },
    { :code=>"IT-00015", :name=>"DIRECT SUPRA YELLOW RL", :retail_price=>10.00, :stock=>10, :is_active => true },
    { :code=>"IT-00016", :name=>"DIRECT SUPRA YELLOW PG", :retail_price=>8.75, :stock=>10, :is_active => true },
    { :code=>"IT-00017", :name=>"DIRECT SUPRA ORANGE 2GL", :retail_price=>6.00, :stock=>10, :is_active => true }
  ]

  direct_items.each do |item|
    direct.items.build(item)
    direct.save
  end

  puts "======== Seeding Reactive Item Data ========="
  reactive = Category.find 3
  
  reactive_items = [
    { :code=>"IT-00018", :name=>"STARFIX YELLOW 3RFN", :retail_price=>3.75, :stock=>10, :is_active => true },
    { :code=>"IT-00019", :name=>"STARFIX ORANGE ED2R/BF2R", :retail_price=>4.27, :stock=>10, :is_active => true },
    { :code=>"IT-00020", :name=>"STARFIX YELLOW 4GL", :retail_price=>6.90, :stock=>10, :is_active => true },
    { :code=>"IT-00021", :name=>"STARFIX YELLOW HF3R", :retail_price=>4.20, :stock=>10, :is_active => true },
    { :code=>"IT-00022", :name=>"STARFIX BLACK DCO/HFGR", :retail_price=>5.70, :stock=>10, :is_active => true },
    { :code=>"IT-00023", :name=>"STARFIX BLACK B 133%", :retail_price=>5.40, :stock=>10, :is_active => true },
    { :code=>"IT-00024", :name=>"STARFIX BLUE R SPC 140%", :retail_price=>16.00, :stock=>10, :is_active => true }
  ]

  reactive_items.each do |item|
    reactive.items.build(item)
    reactive.save
  end  
end