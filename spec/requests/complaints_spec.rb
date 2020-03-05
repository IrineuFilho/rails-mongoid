# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ComplaintsController, type: :request do
  describe 'Http Status' do
    context 'Complaints#index' do
      let(:city) { create(:city) }
      let(:company) { create(:company, locale: city) }
      let(:complaint) { create(:complaint, company: company, locale: city) }

      it {
        get '/complaints'
        expect(response).to have_http_status(:ok)
      }
      it {
        get '/complaints', params: {}
        expect(response).to have_http_status(:ok)
      }
      it {
        get '/complaints', params: { locale: city.name }
        expect(response).to have_http_status(:ok)
      }
      it {
        get '/complaints', params: { company_id: company.id }
        expect(response).to have_http_status(:ok)
      }
    end

    context 'Complaints#show' do
      let!(:complaint) { create(:complaint) }
      it {
        get "/complaints/#{complaint.id}"
        expect(response).to have_http_status(:ok)
      }
    end

    context 'Complaints#create' do
      let(:city) { create(:city) }
      let(:customer) { create(:customer, locale: city) }
      let(:company) { create(:company) }
      let(:complaint_attributes) { { title: 'Test', description: 'Description', company_id: company.id, customer_id: customer.id } }

      it {
        post('/complaints', params: complaint_attributes)
        expect(response).to have_http_status(:created)
      }
    end

    context 'Complaints#destroy' do
      let!(:complaint) { create(:complaint) }
      it {
        get "/complaints/#{complaint.id}"
        expect(response).to have_http_status(:ok)
      }
    end
  end
end
