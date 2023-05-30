# frozen_string_literal: true

class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.where(patient_id: current_user.id)
  end

  def show
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @appointment }
    end
  end

  def create
    @appointment = Appointment.new(create_params)
    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      redirect_to root_path
    end
  end

  private

  def create_params
    appointment_params.except(:category_id)
  end

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :appointment_date, :patient_id)
  end
end
