# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_complaint, only: %i[show destroy]

  api :GET, '/customers', 'List customers'
  param :name, String, desc: "Part of customer's name", required: false
  param :email, String, desc: "Part of customer's email", required: false
  param :locale, String, desc: "Part of customer's cities", required: false
  see 'locales#index', 'list of available cities'
  def index
    @customers = ::Queries::CustomerQuery.call(permitted_fields)
    render json: @customers
  end

  api :GET, '/customers/:id', "Customer's detail"
  param :id, String, desc: "Customer's ID", required: true
  def show
    render json: @customer
  end

  api :POST, '/customers', 'Create a customer'
  param :name, String, desc: "Customer's name", required: true
  param :email, String, desc: "Customers's email", required: true
  param :locale, String, desc: 'Exact name of City', required: true
  see 'locales#index', 'list of available cities'
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

  api :DELETE, '/customers/:id', 'Delete a customer'
  param :id, String, desc: "Customer's ID", required: true
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
