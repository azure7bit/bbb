puts "========= Seeding Roles Data ========="
['Superadmin', 'Sales', 'Purchase', 'Finance'].each do |role|
  Role.find_or_create_by_name role
end