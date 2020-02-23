# frozen_string_literal: true

class ComplaintsController < ApplicationController
  before_action :set_complaintt, only: %i[show update destroy]

  def index
    @complaintts = Complaint.all

    render json: @complaintts
  end

  def show
    render json: @complaintt
  end

  def create
    @complaintt = Complaint.create(complaintt_params)
    if @complaintt.persisted?
      render json: @complaintt, status: :created
    else
      render json: @complaint.errors, status: :unprocessable_entity
    end
  end

  def update
    if @complaint.update(complaint_params)
      render json: @complaint
    else
      render json: @complaint.errors, status: :unprocessable_entity
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
      .require(:complaint)
      .permit(:title,
              :description,
              :locale_id,
              :company_id,
              :customer_id)
  end
end
