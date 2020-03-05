# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::ComplaintResponses::CreateComplaintResponseService, type: :service do
  let(:complaint) { create(:complaint) }
  let(:company) { create(:company) }

  let(:complaint_response_attributes) do
    {
      response_text: 'description complaint',
      owner_id: company.id,
      owner_type: 'Company',
      complaint_id: complaint.id
    }
  end

  subject { ::Services::ComplaintResponses::CreateComplaintResponseService.new(complaint_response_attributes) }

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
      let(:complaint_response_attributes) do
        {
          response_text: '',
          owner_id: company.id,
          owner_type: 'Company',
          complaint_id: complaint.id
        }
      end

      subject { Services::ComplaintResponses::CreateComplaintResponseService.new(complaint_response_attributes) }

      let :result do
        subject.call do |callback|
          callback.on_fail do |errors|
            return errors
          end
        end
      end

      it { expect(result).to be_a(String) }
      it { expect(result).to include('Response text can\'t be blank') }
    end

    context 'when pass wrong owner_type' do
      let(:complaint_response_attributes) do
        {
          response_text: '',
          owner_id: company.id,
          owner_type: 'Test',
          complaint_id: complaint.id
        }
      end

      subject { Services::ComplaintResponses::CreateComplaintResponseService.new(complaint_response_attributes) }

      let :result do
        subject.call do |callback|
          callback.on_fail do |errors|
            return errors
          end
        end
      end

      it { expect { subject.call }.to raise_error(::Exceptions::BadRequestException) }
    end

    context 'when pass wrong complaint_id' do
      let(:complaint_response_attributes) do
        {
          response_text: '',
          owner_id: company.id,
          owner_type: 'Customer',
          complaint_id: 'wrong'
        }
      end

      subject { Services::ComplaintResponses::CreateComplaintResponseService.new(complaint_response_attributes) }

      let :result do
        subject.call do |callback|
          callback.on_fail do |errors|
            return errors
          end
        end
      end

      it { expect { subject.call }.to raise_error(Mongoid::Errors::DocumentNotFound) }
    end
  end
end
