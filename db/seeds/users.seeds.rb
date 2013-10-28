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
    :password_confirmation => 'superadminpassword'
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
    :password_confirmation => 'salesadminpassword'
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
    :password_confirmation => 'purchaseadminpassword'
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
    :password_confirmation => 'financeadminpassword'
  }
)
user.save