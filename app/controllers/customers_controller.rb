# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_complaint, only: %i[show update destroy]

  def index
    @customers = Customer.all

    render json: @customers
  end

  def show
    render json: @customer
  end

  def create
    @customer = Customer.create(customer_params)
    if @customer.persisted?
      render json: @customer, status: :created
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params
      .require(:customer)
      .permit(:name,
              :email)
  end
end
