# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ::Exceptions::BadRequestException, with: :bad_request_response

  def bad_request_response(exception)
    render json: exception.errors, status: :bad_request
  end
end
