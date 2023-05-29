# frozen_string_literal: true

class Appointment < ApplicationRecord
  before_update :close_appointment, if: :recomendation_changed?

  belongs_to :doctor
  belongs_to :patient

  private

  def close_appointment
    return if closed?

    toggle(:closed).save
  end
end
