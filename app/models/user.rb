# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :phone_number, uniqueness: true,
                           presence: true,
                           numericality: true,
                           length: { minimun: 10, maximum: 16 }

  private

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
