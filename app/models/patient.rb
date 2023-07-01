# frozen_string_literal: true

class Patient < User
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
  has_many :time_slots, through: :appointments

  def patient?
    true
  end

  def doctor?
    false
  end
end
