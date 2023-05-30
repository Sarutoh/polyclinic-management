# frozen_string_literal: true

ActiveAdmin.register Patient do
  permit_params :first_name, :last_name, :email, :phone_number, :password

  form title: 'New Patient' do |_f|
    inputs 'Details' do
      input :first_name
      input :last_name
      input :email
      input :phone_number
      input :password
    end
    actions
  end
end
