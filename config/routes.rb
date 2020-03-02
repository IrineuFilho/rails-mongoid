# frozen_string_literal: true

Rails.application.routes.draw do
  resources :complaints do
    resources :complaint_responses, only: %i[create update destroy]
  end

  resources :companies
  resources :customers
end
