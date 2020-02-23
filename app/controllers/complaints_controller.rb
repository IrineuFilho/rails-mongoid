# frozen_string_literal: true

class ComplaintsController < ApplicationController
  before_action :set_complaint, only: %i[show update destroy]

  def index
    @complaints = Complaint.all

    render json: @complaints
  end

  def show
    render json: @complaint
  end

  def create
    @complaint = Complaint.create(complaint_params)
    if @complaint.persisted?
      render json: @complaint, status: :created
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
