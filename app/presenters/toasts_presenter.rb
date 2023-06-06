# frozen_string_literal: true

class ToastsPresenter < BasePresenter
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
    if message.respond_to?(:key)
      key = message.keys.first

      "#{key.capitalize} #{message[key].first}"
    else
      message
    end
  end
end
