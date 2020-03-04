# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_complaint, only: %i[show destroy]

  def index
    @customers = ::Queries::CustomerQuery.call(permitted_fields)

    render json: @customers
  end

  def show
    render json: @customer
  end

  def create
    ::Services::Customers::CreateCustomerService.new(customer_params).call do |callback|
      callback.on_success do |customer|
        render json: customer, status: :created
      end
      callback.on_fail do |errors|
        render json: errors, status: :unprocessable_entity
      end
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
      .permit(:name,
              :email,
              :locale)
  end

  def permitted_fields
    customer_params
  end
end
