after :users do
  puts "========= Seeding Type Account Data ========="
  ['Aktiva', 'Kewajiban', 'Modal', 'Pendapatan', 'Biaya'].each do |tp|
    TypeAccount.create(:name => tp)
  end
end