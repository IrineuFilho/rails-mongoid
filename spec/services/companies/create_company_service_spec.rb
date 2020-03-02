# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Companies::CreateCompanyService, type: :service do
  let(:city) { create(:city) }
  let(:company_attributes) { attributes_for(:company, name: 'Company A', cnpj: '2', locale: city.name) }

  subject { Services::Companies::CreateCompanyService.new(company_attributes) }

  describe 'responto_to method' do
    context 'call' do
      it { expect(subject.respond_to?(:call)).to be }
    end
  end

  describe 'call method' do
    context 'when pass correct params' do
      it '' do
        subject.call do |callback|
          callback.on_success do |comp|
            expect(comp.persisted?).to be
          end
        end
      end
    end
    context 'when missig some params' do
      let(:company_attributes) { attributes_for(:company, name: '', cnpj: '2', locale: city.name) }

      subject { Services::Companies::CreateCompanyService.new(company_attributes) }

      let :result do
        subject.call do |callback|
          callback.on_fail do |errors|
            return errors
          end
        end
      end

      it { expect(result).to be_a(String) }
      it { expect(result).to include('Name can\'t be blank') }
    end
  end
end
