# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Complaints::CreateComplaintService, type: :service do
  let(:city) { create(:city) }
  let(:customer) { create(:customer, locale: city) }
  let(:company) { create(:company) }

  let(:complaint_attributes) do
    {
      title: 'title complaint',
      description: 'description complaint',
      customer_id: customer.id,
      company_id: company.id
    }
  end

  subject { Services::Complaints::CreateComplaintService.new(complaint_attributes) }

  describe 'responto_to method' do
    context 'call' do
      it { expect(subject.respond_to?(:call)).to be }
    end
  end

  describe 'call method' do
    context 'when pass correct params' do
      let(:result) do
        subject.call do |callback|
          callback.on_success do |comp|
            return comp
          end
        end
      end

      it { expect(result.persisted?).to be }
    end

    context 'when missig some params' do
      let(:complaint_attributes) do
        {
          title: '',
          description: '',
          customer_id: customer.id,
          company_id: company.id
        }
      end

      subject { Services::Complaints::CreateComplaintService.new(complaint_attributes) }

      let :result do
        subject.call do |callback|
          callback.on_fail do |errors|
            return errors
          end
        end
      end

      it { expect(result).to be_a(String) }
      it { expect(result).to include('Title can\'t be blank') }
      it { expect(result).to include('Description can\'t be blank') }
    end
  end
end
