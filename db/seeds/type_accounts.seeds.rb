after :users do
  puts "========= Seeding Type Account Data ========="
  ['Aktiva', 'Kewajiban', 'Modal', 'Pendapatan', 'Biaya'].each do |tp|
    TypeAccount.find_or_create_by_name tp
  end
end