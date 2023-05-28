FactoryBot.define do
  factory :patient do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    password { Faker::Internet.password }
  end
end