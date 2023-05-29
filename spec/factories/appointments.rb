# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    doctor { create(:doctor) }
    patient { create(:patient) }
    appointment_date { 2.days.from_now }
  end
end
