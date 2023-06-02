# frozen_string_literal: true

class ToastPresenter < BasePresenter
  BASE = 'base'
  FLASH_CLASSES = {
    notice: 'bg-info',
    success: 'bg-success',
    alert: 'bg-warning'
  }.freeze

  def flash_class(type)
    "toast-header #{FLASH_CLASSES[type.to_sym]}"
  end

  def include_flash?(type)
    FLASH_CLASSES.include?(type.to_sym)
  end

  def handle_message(message)
    if !message.respond_to?(:key)
      message
    elsif message.keys.first == BASE
      message[BASE].first
    else
      key = message.keys.first

      "#{key.capitalize} #{message[key].first}"
    end
  end
end
