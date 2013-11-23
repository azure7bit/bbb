puts "========= Seeding Users Data ========="
user = {
    :username => 'superadmin',
    :date_registered => DateTime.now,
    :id_card => 1234567890,
    :first_name => 'Admin',
    :last_name => 'User',
    :is_active => true,
    :email => 'superadmin@bbb.com',
    :password => 'superadminpassword',
    :password_confirmation => 'superadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '093484843943'
  }
superadmin = Role.find 1
superadmin.users.build(user).save

user = {
    :username => 'salesadmin',
    :date_registered => DateTime.now,
    :id_card => 3234567890,
    :first_name => 'Sales',
    :last_name => 'User',
    :is_active => true,
    :email => 'salesadmin@bbb.com',
    :password => 'salesadminpassword',
    :password_confirmation => 'salesadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '3484843943'
  }
sales = Role.find 2
sales.users.build(user).save

user = {
    :username => 'purchaseadmin',
    :date_registered => DateTime.now,
    :id_card => 4234567890,
    :first_name => 'Purchase',
    :last_name => 'User',
    :is_active => true,
    :email => 'purchaseadmin@bbb.com',
    :password => 'purchaseadminpassword',
    :password_confirmation => 'purchaseadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '3484843943'
  }
purchase = Role.find 3
purchase.users.build(user).save

user = {
    :username => 'financeadmin',
    :date_registered => DateTime.now,
    :id_card => 2234567890,
    :first_name => 'Finance',
    :last_name => 'User',
    :is_active => true,
    :email => 'financeadmin@bbb.com',
    :password => 'financeadminpassword',
    :password_confirmation => 'financeadminpassword',
    :address => 'Jln. Raya Caringin No. 439 C - Babakan Ciparay Bandung',
    :phone_number => '3484843943'
  }
finance = Role.find 4
finance.users.build(user).save