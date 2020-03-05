# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompaniesController, type: :request do
  describe 'Http Status' do
    context 'Companies#index' do
      let(:city) { create(:city) }
      let(:company) { create(:company, locale: city) }

      it {
        get '/companies'
        expect(response).to have_http_status(:ok)
      }
      it {
        get '/companies', params: {}
        expect(response).to have_http_status(:ok)
      }
      it {
        get '/companies', params: { locale: city.name }
        expect(response).to have_http_status(:ok)
      }
      it {
        get '/companies', params: { name: company.name }
        expect(response).to have_http_status(:ok)
      }
    end

    context 'Companies#index' do
      let!(:company) { create(:company) }
      it {
        get "/companies/#{company.id}"
        expect(response).to have_http_status(:ok)
      }
    end

    context 'Companies#create' do
      let(:city) { create(:city) }
      let(:company_attributes) { attributes_for(:company, locale: city.name) }

      it {
        post('/companies', params: company_attributes)
        expect(response).to have_http_status(:created)
      }
    end

    context 'Companies#destroy' do
      let!(:company) { create(:company) }
      it {
        get "/companies/#{company.id}"
        expect(response).to have_http_status(:ok)
      }
    end
  end
end
