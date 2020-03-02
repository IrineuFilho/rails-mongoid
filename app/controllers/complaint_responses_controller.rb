# frozen_string_literal: true

class ComplaintResponsesController < ApplicationController
  PERMITTED_OWNER_TYPE = %w[Customer Company].freeze

  before_action :set_complaint, only: %i[create update destroy]
  before_action :set_complaint_response, only: %i[update destroy]
  before_action :check_permmited_owner_type, only: %i[create]

  def create
    @complaint_response = ComplaintResponse
                          .create(complaint_response_params
                                          .merge(complaint: @complaint))
    if @complaint_response.persisted?
      render json: @complaint_response, status: :created
    else
      render json: @complaint_response.errors, status: :unprocessable_entity
    end
  end

  def update
    if @complaint_response.update(complaint_response_params)
      render json: @complaint_response
    else
      render json: @complaint_response.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @complaint_response.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def set_complaint
    @complaint = Complaint.find(params[:complaint_id])
  end

  def set_complaint_response
    @complaint_response = @complaint.complaint_responses.find({ id: params[:id] })
  end

  def check_permmited_owner_type
    return if params[:owner_type].presence_in(PERMITTED_OWNER_TYPE)

    raise ::Exceptions::BadRequestException, ['owner type must be Customer or Company']
  end

  def complaint_response_params
    params
      .require(:complaint_response)
      .permit(:response_text,
              :owner_id,
              :owner_type)
  end
end
