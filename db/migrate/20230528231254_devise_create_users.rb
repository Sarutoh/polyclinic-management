# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name,         null: false, default: ''
      t.string :last_name,          null: false, default: ''
      t.string :email,              null: false, default: ''
      t.string :phone_number,       null: false, default: ''
      t.string :type,               null: false, default: Patient.name
      t.string :encrypted_password, null: false, default: ''

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :phone_number,         unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
