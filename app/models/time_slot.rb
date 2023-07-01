# frozen_string_literal: true

class TimeSlot < ApplicationRecord
  belongs_to :appointment

  scope :by_date, ->(date) { where(appointment_date: date) }
end
