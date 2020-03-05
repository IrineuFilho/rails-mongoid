# frozen_string_literal: true

class ComplaintsController < ApplicationController
  before_action :set_complaint, only: %i[show destroy]

  api :GET, '/complaints', 'List of complaints. You can filter complaints based on params informed. The query will use \'and\' in the case more than one parameter are informed'
  param :company_id, String, desc: "Company's ID", required: false
  param :customer_id, String, desc: "Customer's ID", required: false
  param :locale, String, desc: 'Exact City name', required: false
  param :title, String, desc: 'Part of title', required: false
  param :description, String, desc: 'Part of description', required: false
  see 'locales#index', 'list of available cities'
  def index
    begin
      result = ::Queries::ComplaintQuery.call(complaints_search_params.to_h)
    rescue ArgumentError
      render json: 'Some arguntment you passed is invalid', status: :unprocessable_entity
    rescue BSON::ObjectId::Invalid
      render json: 'company_id or customer_id are invalid', status: :unprocessable_entity
    end

    render json: result
  end

  api :GET, '/complaints/:id', "Complaint's detail"
  param :id, String, desc: "Complaint's ID", required: true
  def show
    render json: @complaint
  end

  api :POST, '/complaints', 'Create a Complaint'
  param :title, String, desc: "Complaint's title", required: true
  param :description, String, desc: "Complaint's description", required: true
  param :company_id, String, desc: "Complaint's company_id", required: false
  param :customer_id, String, desc: "Complaint's customer_id", required: false
  see 'companies#index', 'list of companies available'
  see 'customers#index', 'list of customers available'
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

  api :DELETE, '/complaints/:id', 'Delete a complaint'
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
      .permit(:locale, :company_id, :customer_id, :title, :description)
      .to_h
  end
end
