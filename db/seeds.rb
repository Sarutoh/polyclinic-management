# frozen_string_literal: true

if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end

if Rails.env.production?
  AdminUser.create!(
    email: Rails.application.credentials.admin.fetch(:email),
    password: Rails.application.credentials.admin.fetch(:password),
    password_confirmation: Rails.application.credentials.admin.fetch(:password)
  )
  Category.DEFAULT_CATEGORIES.each { |dc| Category.create(dc) }
end
