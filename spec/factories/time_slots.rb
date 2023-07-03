# frozen_string_literal: true

FactoryBot.define do
  factory :time_slot do
    appointment_date { Date.tomorrow.midday.change(hour: (10..18).to_a.sample) }
  end
end
