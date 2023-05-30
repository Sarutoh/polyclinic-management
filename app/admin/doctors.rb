# frozen_string_literal: true

ActiveAdmin.register Doctor do
  permit_params :first_name, :last_name, :email, :phone_number, :password, :category_id

  form title: 'New Doctor' do |_f|
    inputs 'Details' do
      input :first_name
      input :last_name
      input :email
      input :phone_number
      input :password
      input :category_id, as: :select, collection: Category.all
    end
    actions
  end
end
