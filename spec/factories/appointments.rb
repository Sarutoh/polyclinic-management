# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    doctor { create(:doctor) }
    patient { create(:patient) }
    association :time_slot
    # after(:create) do |appointment|
    #   appointment.time_slot = create(:time_slot, appointment: appointment)
    # end
  end
end
