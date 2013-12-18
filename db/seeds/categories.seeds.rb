puts "======== Seeding Categories Data ========="
Category.create!([
{ :code=>"CAT001", :name=>"Category 001", :unit=>"KG", :is_active=>true }
])