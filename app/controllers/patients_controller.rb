# frozen_string_literal: true

class PatientsController < ApplicationController
  before_action :authenticate_user!

  def slots
    # Slot logic call here
    # @slots = Patient.find(params[:doctorId]).slots[Time.now.strftime('%A').downcase.to_sym]
    before = [10, 11, 12, 13]
    after = [14, 15, 16, 17]
    @slots = (before.sample..after.sample)

    respond_to do |format|
      format.turbo_stream
    end
  end
end
