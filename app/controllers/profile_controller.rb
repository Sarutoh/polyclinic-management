# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize! :create, Appointment

    @categories = Category.all
    @last = AppointmentsQuery.new(current_user).last_appointment
    @nearest = AppointmentsQuery.new(current_user).nearest_appointment
  end
end
