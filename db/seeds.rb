users = [
  { email: 'admin@email.com',
    password: 'P@ssw0rd',
    approved: true,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart
  },
  {
    email: Faker::Internet.unique.email,
    password: 'P@ssw0rd',
    approved: false,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart
  },
  {
    email: Faker::Internet.unique.email,
    password: 'P@ssw0rd',
    approved: true,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Hacker.say_something_smart
  },
  # for testing OmniAuth SSO
  {
    email: 'thuy.ngo@econsys.com',
    password: 'P@ssw0rd',
    approved: true,
    uid: ENV["GCP_OAUTH_UID"],
    provider: 'google_oauth2'
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
