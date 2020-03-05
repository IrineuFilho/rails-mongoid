# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Apipie::ParamInvalid do |e|
      render json: e, status: :bad_request
    end

    rescue_from ::Exceptions::BadRequestException do |e|
      render json: e.errors, status: :bad_request
    end

    rescue_from ActionController::BadRequest do |e|
      render json: e.message, status: :bad_request
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      render json: e.message, status: :not_found
    end
  end
end
