# frozen_string_literal: true

module ApplicationHelper
  def handle_devise_errors(resource)
    return unless resource.errors.any?

    flash.now[:alert] =
      (I18n.t('errors.messages.not_saved',
              count: resource.errors.count,
              resource: resource.class.model_name.human.downcase).capitalize + errors_ul(resource)).html_safe
  end

  private

  def errors_ul(resource)
    list = resource.errors.full_messages.map { |m| "<li>#{m}" }.join('</li>')
    "<ul> #{list}</ul>"
  end
end
