# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_sign_in_params, if: :devise_controller?

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[phone_number first_name last_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[avatar first_name last_name email])
  end
end
