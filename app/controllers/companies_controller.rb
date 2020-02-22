# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  def index
    @companies = ::Queries::CompanyQuery.call(company_filter, direction: params[:direction].downcase)
    render json: @companies
  end

  def show
    render json: @company
  end

  def create
    @company = Company.create(company_params)

    if @company.persisted?
      render json: @company, status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params
      .require(:company)
      .permit(:name,
              :cnpj,
              :city_id)
  end

  def company_filter
    params
      .permit(:name, :cnpj)
  end
end
