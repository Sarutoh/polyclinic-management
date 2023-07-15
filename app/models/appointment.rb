# frozen_string_literal: true

class Appointment < ApplicationRecord
  MAX_OPEN_APPOINTMENTS = 10
  MAX_DATEPICKER_RANGE = 14
  RECOMENDATION_LENGTH = {
    min: 10,
    max: 255
  }.freeze

  before_update :close_appointment, if: :recomendation_changed?

  belongs_to :doctor
  belongs_to :patient
  has_one :time_slot, dependent: :destroy

  validate :validate_max_appointments, :validate_appointment_date, on: :create
  validates :recomendation, length: { minimum: RECOMENDATION_LENGTH[:min], maximum: RECOMENDATION_LENGTH[:max] },
                            on: :update, if: :recomendation_changed?

  def validate_appointment_date
    unless time_slot.appointment_date.between?(
      Time.zone.today.beginning_of_day, MAX_DATEPICKER_RANGE.days.from_now.end_of_day
    )
      errors.add(:date, I18n.t('appointment.invalid_date'))
    end
  end

  def validate_max_appointments
    return unless doctor.appointments.where(closed: false).count >= MAX_OPEN_APPOINTMENTS

    errors.add(:doctor, I18n.t('appointment.reach_the_maximum'))
  end

  private

  def close_appointment
    return if closed? || recomendation.empty?

    toggle(:closed).save
  end
end
