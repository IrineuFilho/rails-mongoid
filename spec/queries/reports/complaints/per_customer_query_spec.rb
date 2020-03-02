# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Reports::Complaints::PerCustomerQuery, type: :query do
  subject { Queries::Reports::Complaints::PerCustomerQuery }

  describe 'definition class' do
    context 'should exist call method' do
      it { expect(described_class.respond_to?(:call)).to be }
    end

    context 'should receive 2 arguments' do

      let(:customer) { double("customer") }
      before(:each) do
        allow(customer).to receive(:is_a?) { true }
        allow(customer).to receive(:_id) { 1 }
        allow(subject).to receive(:field_valid?) { true }
      end

      it { expect { subject.call }.to raise_error ArgumentError }
      it { expect { subject.call('id') }.to raise_error ArgumentError }
      it { expect { subject.call(customer, '_id') }.not_to raise_error }
      it { expect { subject.call('', 'id') }.to raise_error ArgumentError }
    end
  end

  describe 'arguments validation' do
    let(:customer) { create(:customer) }
    context 'send invalid arguments' do
      it { expect { subject.call('', 'name') }.to raise_error ArgumentError }
      it { expect { subject.call(customer, 'email') }.to raise_error ArgumentError }
    end

    context 'pass valid arguments' do
      it { expect { subject.call(customer, '_id') }.not_to raise_error }
      it { expect { subject.call(customer, 'name') }.not_to raise_error }
    end

  end

  describe 'returned value' do
    let(:locale) { create(:city) }

    let(:customer_1) { create(:customer) }
    let(:customer_2) { create(:customer) }

    let(:c1) { create(:company, locale: locale) }
    let(:c2) { create(:company, locale: locale) }
    let(:c3) { create(:company) }

    let!(:complaint_1) { create(:complaint, company: c1, customer: customer_1, locale: locale) }
    let!(:complaint_2) { create(:complaint, company: c1, customer: customer_2, locale: locale) }
    let!(:complaint_3) { create(:complaint, company: c3, customer: customer_1) }

    context 'pass customer\'s name' do
      it { expect(subject.call(customer_1, 'name').count).to eq 2 }
      it { expect(subject.call(customer_1, 'name').include?(complaint_1)).to be }
      it { expect(subject.call(customer_1, 'name').include?(complaint_3)).to be }
    end

    context 'pass customer\'s id' do
      it { expect(subject.call(customer_1, '_id').count).to eq 2 }
      it { expect(subject.call(customer_1, '_id').include?(complaint_1)).to be }
      it { expect(subject.call(customer_1, '_id').include?(complaint_3)).to be }
    end
  end
end
