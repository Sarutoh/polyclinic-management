# frozen_string_literal: true

class AppointmentsPresenter < BasePresenter
  include ActionView::Helpers::TagHelper

  WAIT = 'wait_for_recomendation_'
  INFO_BLOCK = 'appointment_info_block_'

  def participant(params)
    user = params[:user]
    appointment = params[:appointment]

    if user.doctor?
      safe_join([tag.div(Patient.name), tag.strong(appointment.patient.full_name.to_s)])
    else
      safe_join([tag.div(Doctor.name), tag.strong(appointment.doctor.full_name.to_s)])
    end
  end

  def wait_to_recomend_id(appointment)
    id = appointment.id

    recomendate_policy(appointment) ? "#{WAIT}#{id}" : "#{INFO_BLOCK}#{id}"
  end

  private

  def recomendate_policy(appointment)
    AppointmentsPolicy.new(appointment).able_to_recomendate?
  end
end
