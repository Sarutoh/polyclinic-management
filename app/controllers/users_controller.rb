# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def list
    authorize! :read, Doctor

    @doctors = Doctor.by_category(params[:categoryId])

    respond_to do |format|
      format.turbo_stream
    end
  end

  def slots
    authorize! :read, TimeSlot

    @patient = Patient.find(params[:patientId])
    @doctor  = Doctor.find(params[:doctorId])

    @slots = Users::SlotsHandler.call(@patient, @doctor, params[:date])

    respond_to do |format|
      format.turbo_stream
    end
  end
end
