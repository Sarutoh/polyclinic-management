# frozen_string_literal: true

module ApplicationHelper
  def devise_error_handler(resource)
    return unless resource.errors.any?

    flash.now[:alert] =
      (I18n.t('errors.messages.not_saved',
              count: resource.errors.count,
              resource: resource.class.model_name.human.downcase).capitalize + errors_ul(resource)).html_safe
  end

  def participant(appointment)
    if current_user.doctor?
      safe_join([tag.div('Patient'), tag.strong(appointment.patient.full_name.to_s)])
    else
      safe_join([tag.div('Doctor'), tag.strong(appointment.doctor.full_name.to_s)])
    end
  end

  def able_to_recomendate?(appointment)
    appointment.appointment_date.past? && !appointment.closed
  end

  def wait_to_recomend_id(appointment)
    id = appointment.id
    able_to_recomendate?(appointment) ? "wait_for_recomendation_#{id}" : "appointment_info_block_#{id}"
  end

  private

  def errors_ul(resource)
    list = resource.errors.full_messages.map { |m| "<li>#{m}" }.join('</li>')
    "<ul> #{list}</ul>"
  end
end
