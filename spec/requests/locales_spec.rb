# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocalesController, type: :request do
  describe 'Http Status' do
    context 'Locales#index' do
      let!(:city) { create(:city, name: 'Maceió') }

      it {
        get '/locales'
        expect(response).to have_http_status(:ok)
      }
      it {
        get '/locales'
        expect(body).to include(city.id)
      }

      it {
        get '/locales', params: { name: 'Mace' }
        expect(body).to include(city.id)
      }
    end
  end
end
