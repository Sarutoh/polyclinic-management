# frozen_string_literal: true

module Users
  class SlotsHandler < BaseService
    def initialize(patient, doctor)
      @patient = patient
      @doctor = doctor
    end

    def call
      available_slots
    end

    def available_slots
      result = { 'this_week' => {}, 'next_week' => {} }
      
      patient.time_slots.each do |week, days|
        days.each do |day, slots|
          result[week][day] = doctor.time_slots[week][day] & slots
        end
      end

      result
    end

    private

    attr_reader :patient, :doctor
  end
end
