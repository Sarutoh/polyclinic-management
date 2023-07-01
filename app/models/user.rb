# frozen_string_literal: true

class User < ApplicationRecord
  after_create :populate_slots
  store_accessor :time_slots, :this_week, :next_week

  EMAIL_LENGTH = {
    min: 10,
    max: 16
  }.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:phone_number]

  validates :phone_number, uniqueness: true,
                           presence: true,
                           numericality: true

  validate :phone_number_length

  has_one_attached :avatar

  def phone_number_length
    errors.add(:phone_number, ' is too short!') if phone_number.length < EMAIL_LENGTH[:min]
    errors.add(:phone_number, ' is too long!') if phone_number.length > EMAIL_LENGTH[:max]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    false
  end

  private

  def populate_slots
    Users::SlotsPopulator.new(self).populate
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
