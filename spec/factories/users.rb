FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.phone_number }
    password { "P@ssw0rd" }
    password_confirmation { "#{password}" }
  end
end
