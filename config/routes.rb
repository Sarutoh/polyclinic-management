# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end

  devise_for :users

  resource :profile, only: :show

  resources :appointments

  root to: 'profile#show'
end
