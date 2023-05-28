# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  private
  
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
