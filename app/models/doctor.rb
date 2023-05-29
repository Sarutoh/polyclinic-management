# frozen_string_literal: true

class Doctor < User
  belongs_to :category

  scope :by_category, ->(category) { where(category_id: category) }
end
