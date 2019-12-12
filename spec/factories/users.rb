require "factory_bot_rails"

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
  end
end
