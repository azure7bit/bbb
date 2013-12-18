puts "======== Seeding Items Data ========="
Item.create!([
{ :code=>"ITM001", :name=>"Urea", :category_id=>1, :retail_price=>4500, :stock=>10, :ci_number=>"5550100", :color => "#FFFFFF", :is_active => true },
{ :code=>"ITM002", :name=>"Direct Light Scarlet F2G 100%", :category_id=>1, :retail_price=>4500, :stock=>10, :ci_number=>"5550100", :color => "#FFFFFF", :is_active => true },
{ :code=>"ITM003", :name=>"Amacron Black S2BG 300%", :category_id=>1, :retail_price=>4500, :stock=>10, :ci_number=>"5550100", :color => "#FFFFFF", :is_active => true },
{ :code=>"ITM004", :name=>"Starfix Black B 133%", :category_id=>1, :retail_price=>4500, :stock=>10, :ci_number=>"5550100", :color => "#FFFFFF", :is_active => true }
])
