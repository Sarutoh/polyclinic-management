# frozen_string_literal: true

class AddTimeSlotsToDoctor < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :time_slots, :jsonb
  end
end
