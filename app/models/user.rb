# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :phone_number, uniqueness: true,
                           presence: true,
                           numericality: true,
                           length: { minimun: 10, maximum: 16 }

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
