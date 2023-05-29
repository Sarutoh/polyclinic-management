# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @current_user = current_user
    @categories = Category.all
  end
end
