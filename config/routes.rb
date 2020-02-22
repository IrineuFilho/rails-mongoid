# frozen_string_literal: true

Rails.application.routes.draw do
  resources :complains
  resources :companies
  resources :customers
end
