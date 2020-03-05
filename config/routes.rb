# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  resources :complaints, only: %i[index show create destroy] do
    resources :complaint_responses, only: %i[create update destroy]
  end

  resources :companies, only: %i[index show create destroy]
  resources :customers, only: %i[index show create destroy]
  resources :locales, only: %i[index]
end
