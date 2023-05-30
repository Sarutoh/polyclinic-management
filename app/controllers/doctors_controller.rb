# frozen_string_literal: true

class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all

    authorize! :read, Doctor
  end

  def create
    authorize! :create, Doctor
  end

  def list
    @doctors = Doctor.by_category(params[:category_id])

    respond_to do |format|
      format.turbo_stream
    end
  end
end
