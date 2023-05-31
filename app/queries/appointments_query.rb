# frozen_string_literal: true

class AppointmentsQuery
  def initialize(user)
    @user = user
  end

  def finished_appointments
    subquery_past.includes(set_includes)
  end

  def planned_appointments
    subquery_future.includes(set_includes)
  end

  def last_appointment
    subquery_past.first
  end

  def nearest_appointment
    subquery_future.first
  end

  private

  attr_reader :user

  def subquery_past
    user.appointments.where('appointment_date < ? ', Time.zone.now).order('appointment_date desc')
  end

  def subquery_future
    user.appointments.where('appointment_date > ? ', Time.zone.now).order('appointment_date asc')
  end

  def set_includes
    user.doctor? ? :patient : :doctor
  end
end
