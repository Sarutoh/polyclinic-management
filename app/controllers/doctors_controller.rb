# frozen_string_literal: true

class DoctorsController < ApplicationController
  before_action :authenticate_user!

  def list
    @doctors = Doctor.by_category(params[:category_id])

    respond_to do |format|
      format.turbo_stream
    end
  end
end
