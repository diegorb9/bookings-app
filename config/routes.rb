# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :bookings

  root 'bookings#index'
end
