puts "======== Seeding Companies Data ========="
Company.create!(:name => "PT. BANDUNG BANGKIT BERSINAR", :address => "Jl. Raya Caringin No. 439 C Babakan - Babakan Ciparay", :city => "Bandung", :npwp => "01.448.784.7.422.000", :kurs => 11250)

puts "======== Seeding Customers Data ========="
Customer.create!([
  {:code => "CS-00001", :first_name => "PT. SINAR SARI SEJATI", :address => "Bandung", :phone_number => "1234456666", :ppn_charge => true},
  {:code => "CS-00002", :first_name => "PT. PROTEX INDONESIA", :address => "Jl. Sadang Rahayu C-9 RT/RW: 001/002 Rahayu-Margaasih", :phone_number => "1234456666", :ppn_charge => true, :npwp => "02.736.443.9-445.000"}
])