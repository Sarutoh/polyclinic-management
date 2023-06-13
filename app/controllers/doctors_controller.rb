# frozen_string_literal: true

class DoctorsController < ApplicationController
  before_action :authenticate_user!

  def list
    @doctors = Doctor.by_category(params[:category_id])

    respond_to do |format|
      format.turbo_stream
    end
  end

  def slots
    # Slot logic call here
    # @slots = Doctor.find(params[:doctor_id]).slots[Time.now.strftime('%A').downcase.to_sym]
    before = [10, 11, 12, 13]
    after = [14, 15, 16, 17]
    @slots = (before.sample..after.sample)

    respond_to do |format|
      format.turbo_stream
    end
  end
end
