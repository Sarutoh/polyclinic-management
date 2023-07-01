# frozen_string_literal: true

module Users
  class SlotsHandler < BaseService
    POSSIBLE_SLOTS = ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00'].freeze

    def initialize(patient, doctor, date)
      @patient = patient
      @doctor = doctor
      @date = Date.parse(date)
    end

    def call
      POSSIBLE_SLOTS - assigned_slots
    end

    def assigned_slots
      patient_slots = user_slots_during_day(patient)
      doctor_slots = user_slots_during_day(doctor)

      patient_slots || doctor_slots
    end

    private

    def user_slots_during_day(user)
      user.time_slots.by_date(date).map(&:starts_at)
    end

    attr_reader :patient, :doctor, :date
  end
end
