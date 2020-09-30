FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.unique.email }
    password { "P@ssw0rd" }
    password_confirmation { "#{password}" }
  end
end
