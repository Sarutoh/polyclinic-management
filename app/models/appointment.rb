# frozen_string_literal: true

class Appointment < ApplicationRecord
  before_update :close_appointment, if: :recomendation_changed?

  belongs_to :doctor
  belongs_to :patient

  validate :validate_max_appointments, on: :create

  def validate_max_appointments
    errors.add(:doctor, 'has too many appointments!') if doctor.appointments.where(closed: false).count >= 10
  end

  private

  def close_appointment
    return if closed? || recomendation.empty?

    toggle(:closed).save
  end
end
