# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Category::DEFAULT_CATEGORIES.sample[:name] }
  end
end
