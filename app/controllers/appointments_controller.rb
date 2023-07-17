# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[edit update show]

  def index
    authorize! :read, Appointment

    @finished = AppointmentsQuery.new(current_user).finished_appointments
    @planned = AppointmentsQuery.new(current_user).planned_appointments
  end

  def show
    authorize! :read, Appointment

    respond_to do |format|
      format.html
      format.json { render json: @appointment }
    end
  end

  def edit
    authorize! :update, Appointment
  end

  def create
    authorize! :create, Appointment, TimeSlot

    @appointment = Appointment.new(create_params)

    if params[:appointment][:time_slot].present?
      appointment_date = DateTime.parse(params[:appointment][:time_slot])
      time_slot = TimeSlot.create(appointment_date: appointment_date)
      @appointment.time_slot = time_slot
    else
      @appointment.errors.add(:slot, t('appointment.empty_slot'))
    end

    respond_to do |format|
      if @appointment.errors.empty? && @appointment.save
        format.html { redirect_to @appointment, notice: t('success.create', record: @appointment.class_name) }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { redirect_to root_path, alert: @appointment.errors }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, Appointment

    respond_to do |format|
      if @appointment.update(update_params)
        format.html do
          redirect_to appointment_path(@appointment), notice: t('success.update', record: @appointment.class_name)
        end
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { redirect_to edit_appointment_path(@appointment), alert: @appointment.errors }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def create_params
    params.require(:appointment).permit(:doctor_id, :appointment_date, :patient_id).except(:category_id, :time_slot)
  end

  def update_params
    params.require(:appointment).permit(:description, :recomendation)
  end
end
