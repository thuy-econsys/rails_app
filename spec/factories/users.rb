FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.unique.email }
    password { "P@ssw0rd" }
    password_confirmation { "#{password}" }
    notes { Faker::Hacker.say_something_smart }

    trait :approved_user do
      approved { true }
    end

    factory :approved_user, traits: [:approved_user]
  end
end
