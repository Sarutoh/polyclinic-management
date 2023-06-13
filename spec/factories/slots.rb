# frozen_string_literal: true

FactoryBot.define do
  factory :slot do
    time { 2.days.from_now }
  end
end
