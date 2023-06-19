# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end

  devise_for :users

  resources :doctors, only: %w[index show] do
    collection do
      get :list
      get :slots
    end
  end

  resources :patients, only: %w[index show] do
    collection do
      get :slots
    end
  end

  resource :profile, only: :show

  resources :appointments

  root to: 'profile#show'
end
