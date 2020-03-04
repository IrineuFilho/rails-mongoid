# frozen_string_literal: true

class ComplaintsController < ApplicationController
  before_action :set_complaint, only: %i[show update destroy]

  def index

    begin
      result = ::Queries::ComplaintQuery.call(complaints_search_params.to_h)
    rescue ArgumentError => e
      render json: 'Some arguntment you passed is invalid', status: :unprocessable_entity
    rescue BSON::ObjectId::Invalid => e
      render json: 'company_id or customer_id are invalid', status: :unprocessable_entity
    end

    render json: result
  end

  def show
    render json: @complaint
  end

  def create
    ::Services::Complaints::CreateComplaintService.new(complaint_params).call do |callback|
      callback.on_success do |complaint|
        render json: complaint, status: :created
      end
      callback.on_fail do |errors|
        render json: errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @complaint.destroy
  end

  private

  def set_complaint
    @complaint = Complaint.find(params[:id])
  end

  def complaint_params
    params
        .permit(:title,
                :description,
                :company_id,
                :customer_id)
  end

  def complaints_search_params
    params
        .permit(:locale, :company_id, :customer_id)
        .to_h
  end
end
