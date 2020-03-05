# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show destroy]

  api :GET, '/companies', 'List companies'
  param :name, String, desc: 'Part of company\'s name'
  param :locale, String, desc: 'Exact name of City', required: false
  param :direction, %w[asc desc], desc: 'Sort Direction. Must be asc or desc'
  def index
    @companies = ::Queries::CompanyQuery.call(company_filter, direction: params_direction)
    render json: @companies
  end

  api :GET, '/companies/:id', "Company's detail"
  param :id, String, desc: "Company's ID", required: true
  def show
    render json: @company
  end

  api :POST, '/companies', 'Create a company'
  param :name, String, desc: "Company's name", required: true
  param :cnpj, String, desc: "Company's CNPJ", required: true
  param :locale, String, desc: 'Exact name of City', required: true
  see 'locales#index', 'list of cities available'
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

  api :DELETE, '/companies/:id', 'Delete a company'
  param :id, String, desc: "Company's ID", required: true
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
