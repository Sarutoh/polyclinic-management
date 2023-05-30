# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @categories = Category.all
    @last = current_user.appointments.where('appointment_date < ? ', Time.zone.now).order('appointment_date desc').first
    @nearest = current_user.appointments.where('appointment_date > ? ',
                                               Time.zone.now).order('appointment_date asc').first
  end
end
