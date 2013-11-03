puts "========= Seeding Users Data ========="
user = User.new(
  {
    :username => 'superadmin',
    :date_registered => DateTime.now,
    :id_card => 1234567890,
    :first_name => 'Admin',
    :last_name => 'User',
    :role_id => 1,
    :is_active => true,
    :email => 'superadmin@bbb.com',
    :password => 'superadminpassword',
    :password_confirmation => 'superadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '093484843943'
  }
)
user.save

user = User.new(
  {
    :username => 'salesadmin',
    :date_registered => DateTime.now,
    :id_card => 3234567890,
    :first_name => 'Sales',
    :last_name => 'User',
    :role_id => 2,
    :is_active => true,
    :email => 'salesadmin@bbb.com',
    :password => 'salesadminpassword',
    :password_confirmation => 'salesadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '3484843943'
  }
)
user.save

user = User.new(
  {
    :username => 'purchaseadmin',
    :date_registered => DateTime.now,
    :id_card => 4234567890,
    :first_name => 'Purchase',
    :last_name => 'User',
    :role_id => 3,
    :is_active => true,
    :email => 'purchaseadmin@bbb.com',
    :password => 'purchaseadminpassword',
    :password_confirmation => 'purchaseadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '3484843943'
  }
)
user.save

user = User.new(
  {
    :username => 'financeadmin',
    :date_registered => DateTime.now,
    :id_card => 2234567890,
    :first_name => 'Finance',
    :last_name => 'User',
    :role_id => 4,
    :is_active => true,
    :email => 'financeadmin@bbb.com',
    :password => 'financeadminpassword',
    :password_confirmation => 'financeadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '3484843943'
  }
)
user.save