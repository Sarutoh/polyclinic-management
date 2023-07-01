# frozen_string_literal: true

module Users
  class SlotsHandler < BaseService
    def initialize(patient, doctor, date)
      @patient = patient
      @doctor = doctor
      @date = date
    end

    def call
      available_slots
    end

    def available_slots
      patient.time_slots
    end

    private

    attr_reader :patient, :doctor, :date
  end
end
