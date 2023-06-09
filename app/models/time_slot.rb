# frozen_string_literal: true

class TimeSlot < ApplicationRecord
  scope :by_date, ->(date) { where(appointment_date: date.all_day) }

  def starts_at
    appointment_date.strftime('%H:%M')
  end
end
