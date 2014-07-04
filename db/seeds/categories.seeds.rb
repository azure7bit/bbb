puts "======== Seeding Statistics Data ========="
Statistic.create!(:total_item => 0, :total_customer => 0, :total_supplier => 0, :total_sales => 0, :total_purchase => 0)

puts "======== Seeding Categories Data ========="
Category.create!([
  { :code => "CT-00001", :name=>"Disperse", :unit=>"KG" },
  { :code => "CT-00002", :name=>"Direct", :unit=>"KG" },
  { :code => "CT-00003", :name=>"Reactive", :unit=>"KG" },
  { :code => "CT-00004", :name=>"Auxeleries", :unit=>"KG" },
  { :code => "CT-00005", :name=>"Default", :unit=>"KG" }
])