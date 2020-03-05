# frozen_string_literal: true

class ComplaintResponsesController < ApplicationController

  before_action :set_complaint, only: %i[destroy]
  before_action :set_complaint_response, only: %i[destroy]

  api :POST, '/complaints/:complaint_id/complaint_responses', 'Create a complaint response in a complaint'
  param :complaint_id, String, desc: "Complaint's ID", required: true
  param :response_text, String, desc: "Response Text", required: true
  param :owner_id, String, desc: "ID of owner response", required: true
  param :owner_type, %w[Customer Company], desc: 'Type of owner response', required: true

  def create
    ::Services::ComplaintResponses::CreateComplaintResponseService.new(complaint_response_params).call do |callback|
      callback.on_success do |complaint_response|
        render json: complaint_response, status: :created
      end
      callback.on_fail do |errors|
        render json: errors, status: :unprocessable_entity
      end
    end
  end

  api :PUT, '/complaints/:complaint_id/complaint_responses/:id', 'Create a complaint response in a complaint'
  param :id, String, desc: "Complaint's response ID will be updated", required: true
  param :complaint_id, String, desc: "Complaint's ID", required: true
  param :response_text, String, desc: "Response Text", required: true
  param :owner_id, String, desc: "ID of owner response", required: true
  param :owner_type, %w[Customer Company], desc: 'Type of owner response', required: true
  def update
    ::Services::ComplaintResponses::CreateComplaintResponseService.new(complaint_response_params).call do |callback|
      callback.on_success do |complaint_response|
        render json: complaint_response, status: :ok
      end
      callback.on_fail do |errors|
        render json: errors, status: :unprocessable_entity
      end
    end
  end

  api :DELETE, '/complaints/:complaint_id/complaint_responses/:id', 'Delete a complaint response'
  param :complaint_id, String, desc: "Complaint's ID", required: true
  param :id, String, desc: "Complaint's response ID", required: true
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
    @complaint_response = @complaint.complaint_responses.find({id: params[:id]})
  end

  def complaint_response_params
    params
        .permit(:id,
                :complaint_id,
                :response_text,
                :owner_id,
                :owner_type)
  end
end
