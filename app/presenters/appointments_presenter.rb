# frozen_string_literal: true

class AppointmentsPresenter < BasePresenter
  include ActionView::Helpers::TagHelper

  WAIT = 'wait_for_recomendation_'
  INFO_BLOCK = 'appointment_info_block_'

  def participant(params)
    user = params[:user]
    appointment = params[:appointment]

    safe_join([tag.div(user_role(user)), tag.strong(opposite_user(user, appointment))])
  end

  def wait_to_recomend_id(appointment)
    id = appointment.id

    recomendate_policy(appointment) ? "#{WAIT}#{id}" : "#{INFO_BLOCK}#{id}"
  end

  def user_role(user)
    user.doctor? ? Patient.name : Doctor.name
  end

  def user_name(params)
    user = params[:user]
    appointment = params[:appointment]

    opposite_user(user, appointment)
  end

  private

  def opposite_user(user, appointment)
    user.doctor? ? appointment.patient.full_name.to_s : appointment.doctor.full_name.to_s
  end

  def recomendate_policy(appointment)
    AppointmentsPolicy.new(appointment).able_to_recomendate?
  end
end
