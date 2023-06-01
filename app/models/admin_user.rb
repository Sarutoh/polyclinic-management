# frozen_string_literal: true

class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]

  def admin?
    true
  end

  def patient?
    false
  end

  def doctor?
    false
  end
end
