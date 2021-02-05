FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.phone_number }
    password { "P@ssw0rd" }
    password_confirmation { "#{password}" }
    notes { Faker::Hacker.say_something_smart }
    
    trait :user_approved do
      approved { true }
    end
    
    trait :user_confirmed do
      confirmed_at { DateTime.now }
    end

    factory :approved_confirmed_user, traits: [ :user_approved, :user_confirmed ]
    factory :unapproved_confirmed_user, traits: [ :user_confirmed ]
  end
end
