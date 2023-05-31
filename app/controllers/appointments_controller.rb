# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :read, Appointment

    @finished = AppointmentsQuery.new(current_user).finished_appointments
    @planned = AppointmentsQuery.new(current_user).planned_appointments
  end

  def show
    authorize! :read, Appointment

    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @appointment }
    end
  end

  def edit
    authorize! :update, Appointment

    @appointment = Appointment.find(params[:id])
  end

  def create
    authorize! :create, Appointment

    @appointment = Appointment.new(create_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { redirect_to root_path }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, Appointment

    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update(update_params)
        format.html { redirect_to appointment_path(@appointment), notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_params
    params.require(:appointment).permit(:doctor_id, :appointment_date, :patient_id).except(:category_id)
  end

  def update_params
    params.require(:appointment).permit(:description, :recomendation)
  end
end
