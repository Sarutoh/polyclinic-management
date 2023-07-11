# frozen_string_literal: true

FactoryBot.define do
  factory :time_slot do
    appointment_date { Time.zone.today.midday.change(hour: (10..18).to_a.sample) }

    trait :passed do
      appointment_date { Time.zone.now.beginning_of_hour }
    end
  end
end
