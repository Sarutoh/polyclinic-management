# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    doctor { create(:doctor) }
    patient { create(:patient) }
    association :time_slot

    trait :closed do
      closed { true }
    end
  end
end
