class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def list
    # binding.pry
    @doctors = Doctor.by_category(params[:category_id])

    respond_to do |format|
      format.turbo_stream
    end
  end
end