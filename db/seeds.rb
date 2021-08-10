users = [
  { email: 'admin@email.com',
    password: ENV["PASSWORD"],
    approved: true,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart
  },
  {
    email: Faker::Internet.unique.email,
    password: ENV["PASSWORD"],
    approved: false,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart
  },
  {
    email: Faker::Internet.unique.email,
    password: ENV["PASSWORD"],
    approved: true,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart
  }
]

users.each do |user_data|
  user = User.find_by(email: user_data[:email])
  user ||= User.new

  user_data.each do |k,v|
    user.send("#{k}=",v)
  end
  
  user.save!(validate: false)
end
