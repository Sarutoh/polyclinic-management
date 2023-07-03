# frozen_string_literal: true

class AppointmentsPolicy
  def initialize(appointment)
    @appointment = appointment
  end

  def able_to_recomendate?
    appointment.time_slot.appointment_date.past? && !appointment.closed
  end

  private

  attr_reader :appointment
end
