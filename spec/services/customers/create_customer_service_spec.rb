# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Customers::CreateCustomerService, type: :service do
  let(:city) { create(:city) }

  describe 'responto_to method' do
    let(:customer_attributes) { attributes_for(:customer, locale: city.name) }

    subject { Services::Customers::CreateCustomerService.new(customer_attributes) }

    context 'call' do
      it { expect(subject.respond_to?(:call)).to be }
    end
  end

  describe 'call method' do
    context 'when pass correct params' do
      let(:customer_attributes) { attributes_for(:customer, locale: city.name) }

      subject { Services::Customers::CreateCustomerService.new(customer_attributes) }

      it {
        subject.call do |callback|
          callback.on_success do |customer|
            expect(customer.persisted?).to be
          end
        end
      }

      it {
        subject.call do |callback|
          callback.on_success do |customer|
            expect(customer).to be_a(Customer)
          end
        end
      }
    end
    context 'when missig name parameter' do
      let(:customer_attributes) { attributes_for(:customer, :without_name, locale: city.name) }

      subject { Services::Customers::CreateCustomerService.new(customer_attributes) }

      let(:result) do
        subject.call do |callback|
          callback.on_fail do |errors|
            return errors
          end
        end
      end

      it { expect(result).to be_a(String) }
      it { expect(result).to include('Name can\'t be blank') }
    end
    context 'when missig email parameter' do
      let(:customer_attributes) { attributes_for(:customer, :without_email, locale: city.name) }

      subject { Services::Customers::CreateCustomerService.new(customer_attributes) }

      let :result do
        subject.call do |callback|
          callback.on_fail do |errors|
            return errors
          end
        end
      end

      it { expect(result).to be_a(String) }
      it { expect(result).to include('Email can\'t be blank') }
    end
  end
end
