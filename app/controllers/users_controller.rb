# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def list
    @doctors = Doctor.by_category(params[:categoryId])

    respond_to do |format|
      format.turbo_stream
    end
  end

  def slots
    # TODO: call service that handle users slots for patient and doctor
    # @patient = Patient.find(params[:patientID])
    # @doctor = Doctor.find(params[:DoctorID])

    before = [10, 11, 12, 13]
    after = [14, 15, 16, 17]
    @slots = (before.sample..after.sample)

    respond_to do |format|
      format.turbo_stream
    end
  end
end
