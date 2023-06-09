# frozen_string_literal: true

class Doctor < User
  belongs_to :category
  has_many :appointments, dependent: :destroy
  has_many :time_slots, through: :appointments
  has_many :patients, through: :appointments

  scope :by_category, ->(category) { where(category_id: category) }

  def patient?
    false
  end

  def doctor?
    true
  end
end
