# frozen_string_literal: true

class AddDefaultValuesForAppointmentFields < ActiveRecord::Migration[7.0]
  def up
    Appointment.where(description: nil).update_all(description: '')
    Appointment.where(recomendation: nil).update_all(recomendation: '')

    change_column :appointments, :description, :string, null: false, default: '' # rubocop:disable Rails/BulkChangeTable
    change_column :appointments, :recomendation, :string, null: false, default: ''
  end

  def down
    change_column :appointments, :description, :string # rubocop:disable Rails/BulkChangeTable
    change_column :appointments, :recomendation, :string
  end
end
