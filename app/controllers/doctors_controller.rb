# frozen_string_literal: true

class DoctorsController < ApplicationController
  def list
    @patients = Patients.all

    respond_to do |format|
      format.turbo_stream
    end
  end
end
