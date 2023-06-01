# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    can %i[read create update], Appointment, user: user
    can :read, Doctor, user: user

    return unless user.doctor?

    can %i[read create update], Appointment, user: user

    return unless user.admin?

    can %i[read create update], Doctor, user: user
  end
end
