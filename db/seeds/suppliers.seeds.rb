after :items do
  puts "======== Seeding Suppliers Data ========="
  Supplier.create!([
    { :code=>"SP-00001", :first_name=>"Artha", :last_name=>"Christa", :address=>"123 1st Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00002", :first_name=>"AMC", :last_name=>"-", :address=>"123 2nd Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00003", :first_name=>"Cahaya", :last_name=>"Kurnia", :address=>"123 3rd Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00004", :first_name=>"Colorich", :last_name=>"-", :address=>"123 4th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00005", :first_name=>"Fercho", :last_name=>"-", :address=>"123 5th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00006", :first_name=>"Gemilang", :last_name=>"-", :address=>"123 6th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00007", :first_name=>"Inti", :last_name=>"Colour", :address=>"123 7th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00008", :first_name=>"Junius", :last_name=>"-", :address=>"123 8th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00009", :first_name=>"Kromatindo", :last_name=>"-", :address=>"123 9th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00010", :first_name=>"Kusworo", :last_name=>"-", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00011", :first_name=>"Lautan", :last_name=>"Luas", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00012", :first_name=>"Lisiang", :last_name=>"-", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00013", :first_name=>"Jimmy", :last_name=>"-", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00014", :first_name=>"Mitra", :last_name=>"Tunggal", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00015", :first_name=>"MCU", :last_name=>"-", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00016", :first_name=>"Multy", :last_name=>"Kimia", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00017", :first_name=>"PO", :last_name=>"Goan", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00018", :first_name=>"Sarichem", :last_name=>"-", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00019", :first_name=>"Sinar", :last_name=>"Syno", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00020", :first_name=>"Sentra", :last_name=>"Kemika", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00021", :first_name=>"Tony", :last_name=>"-", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00022", :first_name=>"Titian", :last_name=>"-", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00023", :first_name=>"Tiga", :last_name=>"Warna", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" },
    { :code=>"SP-00024", :first_name=>"Warna", :last_name=>"Jaya", :address=>"123 10th Street", :city=>"Bandung", :phone_number=>"5550100" }
  ])
end