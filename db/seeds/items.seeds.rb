after :categories do
  puts "======== Seeding Disperse Item Data ========="
  disperse = Category.find 1
  
  items = [
    { :code=>"IT-00001", :name=>"DISPERSE RED BEL", :stock=>10, :is_active => true },
    { :code=>"IT-00002", :name=>"DISPERSE RED FB", :stock=>10, :is_active => true },
    { :code=>"IT-00003", :name=>"DISPERSE FLOUR PINK 2R", :stock=>10, :is_active => true },
    { :code=>"IT-00004", :name=>"DISPERSE RUBINE S2GFL", :stock=>10, :is_active => true },
    { :code=>"IT-00005", :name=>"DISPERSE BROWN SR", :stock=>10, :is_active => true },
    { :code=>"IT-00006", :name=>"DISPERSE ORANGE 2GF", :stock=>10, :is_active => true },
    { :code=>"IT-00007", :name=>"DISPERSE VIOLET S4RL", :stock=>10, :is_active => true },
    { :code=>"IT-00008", :name=>"DISPERSE VIOLET 31 150%", :stock=>10, :is_active => true },
    { :code=>"IT-00009", :name=>"DISPERSE TURQ BLUE SGL", :stock=>10, :is_active => true },
    { :code=>"IT-00010", :name=>"DISPERSE RED F3BS", :stock=>10, :is_active => true }
  ]

  items.each do |item|
    disperse.items.build(item)
    disperse.save
  end

  puts "======== Seeding Direct Item Data ========="
  direct = Category.find 2
  
  direct_items = [
    { :code=>"IT-00011", :name=>"DIRECT SUPRA ROSE FR", :stock=>10, :is_active => true },
    { :code=>"IT-00012", :name=>"DIRECT SUPRA BLUE BRL", :stock=>10, :is_active => true },
    { :code=>"IT-00013", :name=>"DIRECT BLUE 4BL", :stock=>10, :is_active => true },
    { :code=>"IT-00014", :name=>"DIRECT LIGHT SCARLET F2G", :stock=>10, :is_active => true },
    { :code=>"IT-00015", :name=>"DIRECT SUPRA YELLOW RL", :stock=>10, :is_active => true },
    { :code=>"IT-00016", :name=>"DIRECT SUPRA YELLOW PG", :stock=>10, :is_active => true },
    { :code=>"IT-00017", :name=>"DIRECT SUPRA ORANGE 2GL", :stock=>10, :is_active => true }
  ]

  direct_items.each do |item|
    direct.items.build(item)
    direct.save
  end

  puts "======== Seeding Reactive Item Data ========="
  reactive = Category.find 3
  
  reactive_items = [
    { :code=>"IT-00018", :name=>"STARFIX YELLOW 3RFN", :stock=>10, :is_active => true },
    { :code=>"IT-00019", :name=>"STARFIX ORANGE ED2R/BF2R", :stock=>10, :is_active => true },
    { :code=>"IT-00020", :name=>"STARFIX YELLOW 4GL", :stock=>10, :is_active => true },
    { :code=>"IT-00021", :name=>"STARFIX YELLOW HF3R", :stock=>10, :is_active => true },
    { :code=>"IT-00022", :name=>"STARFIX BLACK DCO/HFGR", :stock=>10, :is_active => true },
    { :code=>"IT-00023", :name=>"STARFIX BLACK B 133%", :stock=>10, :is_active => true },
    { :code=>"IT-00024", :name=>"STARFIX BLUE R SPC 140%", :stock=>10, :is_active => true }
  ]

  reactive_items.each do |item|
    reactive.items.build(item)
    reactive.save
  end  
end