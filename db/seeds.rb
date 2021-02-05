users = [
  { email: 'admin@email.com',
    password: 'P@ssw0rd',
    approved: true,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart,
    confirmed_at: DateTime.now
  },
  {
    email: Faker::Internet.unique.email,
    password: 'P@ssw0rd',
    approved: false,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart,
    confirmed_at: DateTime.now
  },
  {
    email: Faker::Internet.unique.email,
    password: 'P@ssw0rd',
    approved: true,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart,
    confirmed_at: DateTime.now
  }
]

users.each do |user_data|
  user = User.find_by(email: user_data[:email])
  user ||= User.new

  user_data.each do |k,v|
    user.send("#{k}=",v)
  end

  user.save!(validate: false)
  user_data[:id] = user.id
end
