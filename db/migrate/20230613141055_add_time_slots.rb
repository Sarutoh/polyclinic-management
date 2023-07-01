# frozen_string_literal: true

class AddTimeSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :time_slots do |t|
      t.datetime :appointment_date, null: false

      t.timestamps

      t.belongs_to :appointment, index: true
    end

    remove_column :appointments, :appointment_date, :datetime
  end
end
