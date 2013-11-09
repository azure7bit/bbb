puts "======== Seeding Supplier Data ========="
Supplier.create!([
  { :code=>"Supplier A", :first_name=>"Andersen", :last_name=>"Elizabeth A", :address=>"123 1st Street", :phone_number=>"5550100" },
  { :code=>"Supplier B", :first_name=>"Weiler", :last_name=>"Cornelia", :address=>"123 2nd Street", :phone_number=>"5550100" },
  { :code=>"Supplier C", :first_name=>"Kelley", :last_name=>"Madeleine", :address=>"123 3rd Street", :phone_number=>"5550100" },
  { :code=>"Supplier D", :first_name=>"Sato", :last_name=>"Naoki", :address=>"123 4th Street", :phone_number=>"5550100" },
  { :code=>"Supplier E", :first_name=>"Hernandez-Echevarria", :last_name=>"Amaya", :address=>"123 5th Street", :phone_number=>"5550100" },
  { :code=>"Supplier F", :first_name=>"Hayakawa", :last_name=>"Satomi", :address=>"123 6th Street", :phone_number=>"5550100" },
  { :code=>"Supplier G", :first_name=>"Glasson", :last_name=>"Stuart", :address=>"123 7th Street", :phone_number=>"5550100" },
  { :code=>"Supplier H", :first_name=>"Dunton", :last_name=>"Bryn Paul", :address=>"123 8th Street", :phone_number=>"5550100" },
  { :code=>"Supplier J", :first_name=>"Sandberg", :last_name=>"Mikael", :address=>"123 9th Street", :phone_number=>"5550100" },
  { :code=>"Supplier K", :first_name=>"Sousa", :last_name=>"Luis", :address=>"123 10th Street", :phone_number=>"5550100" }
])
