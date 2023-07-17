# frozen_string_literal: true

FactoryBot.define do
  factory :patient do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { "+380#{Faker::PhoneNumber.subscriber_number(length: 9)}" }
    password { Faker::Internet.password }
  end
end
