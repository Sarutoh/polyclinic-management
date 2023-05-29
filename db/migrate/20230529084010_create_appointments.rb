class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.text :description
      t.text :recomendation
      t.datetime :appointment_date, null: false
      t.boolean :closed,            null: false, default: false

      t.timestamps

      t.belongs_to :doctor, index: true
      t.belongs_to :patient, index: true
    end
  end
end
