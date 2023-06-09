# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    if user.admin?
      can :manage, :all
    elsif user.doctor?
      can %i[read create update], Appointment
      can %i[read create], TimeSlot
      can :read, Patient
    elsif user.patient?
      can %i[read create], Appointment
      can %i[read create], TimeSlot
      can :read, Doctor
    end
  end
end
