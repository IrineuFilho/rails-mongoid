class ApplicationController < ActionController::API

  rescue_from ::Exceptions::BadRequestException, with: :bad_request_response


  def bad_request_response e
    render json: e.errors, status: :bad_request
  end

end
