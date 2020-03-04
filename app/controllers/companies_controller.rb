# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show destroy]

  def index
    @companies = ::Queries::CompanyQuery.call(company_filter, direction: params_direction)
    render json: @companies
  end

  def show
    render json: @company
  end

  def create
    ::Services::Companies::CreateCompanyService.new(company_params).call do |callback|
      callback.on_success do |company|
        render json: company, status: :created
      end
      callback.on_fail do |errors|
        render json: errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @company.destroy
  end

  private

  def params_direction
    if params[:direction].present?
      params[:direction].downcase
    else
      'asc'
    end
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params
      .permit(:name,
              :cnpj,
              :locale)
  end

  def company_filter
    params
      .permit(:name, :cnpj, :locale)
  end
end
