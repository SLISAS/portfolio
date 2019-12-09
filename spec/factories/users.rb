FactoryBot.define do
  factory :user do
    sequence(:name) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { |n| "TEST_#{n}_password" }
    sequence(:password_confirmation) { |n| "TEST_#{n}_password" }
  end
end
