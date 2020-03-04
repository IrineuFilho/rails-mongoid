# frozen_string_literal: true

Rails.application.routes.draw do
  resources :complaints, only: %i[index show create destroy] do
    resources :complaint_responses, only: %i[create update destroy]
  end

  resources :companies, only: %i[index show create destroy]
  resources :customers, only: %i[index show create destroy]

  namespace :reports do
    namespace :quantitative_reports do
      get '' => 'complaints#index'
      get 'per_city'
    end

    scope :qualitative_reports do
    end
  end
end
