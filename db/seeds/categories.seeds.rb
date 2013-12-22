puts "======== Seeding Categories Data ========="
Category.create!([
	{ :code => "CT-00001", :name=>"Disperse", :unit=>"KG" },
	{ :code => "CT-00002", :name=>"Direct", :unit=>"KG" },
	{ :code => "CT-00003", :name=>"Reactive", :unit=>"KG" },
	{ :code => "CT-00004", :name=>"Auxeleries", :unit=>"KG" },
	{ :code => "CT-00005", :name=>"Default", :unit=>"KG" }
])