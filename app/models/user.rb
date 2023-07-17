# frozen_string_literal: true

class User < ApplicationRecord
  PHONE_LENGTH = {
    min: 9,
    max: 14
  }.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:phone_number]

  validates :phone_number, uniqueness: true,
                           presence: true,
                           numericality: true,
                           length: { minimum: PHONE_LENGTH[:min], maximum: PHONE_LENGTH[:max] }

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    false
  end

  private

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
