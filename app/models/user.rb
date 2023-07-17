# frozen_string_literal: true

class User < ApplicationRecord
  PHONE_LENGTH = 9
  COUNTRY_PHONE_CODE = '+380'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:phone_number]

  validates :phone_number, uniqueness: true,
                           presence: true,
                           numericality: true,
                           length: { is: PHONE_LENGTH }

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_phone_number
    "#{COUNTRY_PHONE_CODE}#{phone_number}"
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
