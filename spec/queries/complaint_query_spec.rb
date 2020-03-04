# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::ComplaintQuery, type: :query do
  describe 'responto_to method call' do
    context do
      it { expect(described_class.respond_to?(:call)).to be }
    end
  end

  describe 'return result' do

    let(:city_1) { create(:city, name: 'Maceió') }
    let(:city_2) { create(:city, name: 'Recife') }

    let(:company_1) { create(:company, name: 'Company A', cnpj: '1') }
    let(:company_2) { create(:company, name: 'Company B', cnpj: '2') }
    let(:company_3) { create(:company, name: 'Company B', cnpj: '3') }

    let(:customer_1) { create(:customer, locale: city_1) }
    let(:customer_2) { create(:customer, locale: city_1) }
    let(:customer_3) { create(:customer, locale: city_2) }

    let!(:complaint_1) { create(:complaint, company: company_1, customer: customer_1, locale: customer_1.locale) }
    let!(:complaint_1_1) { create(:complaint, company: company_1, customer: customer_1, locale: customer_1.locale) }
    let!(:complaint_2) { create(:complaint, company: company_1, customer: customer_2, locale: customer_2.locale) }
    let!(:complaint_3) { create(:complaint, company: company_2, customer: customer_3, locale: customer_3.locale) }
    let!(:complaint_4) { create(:complaint, company: company_2, customer: customer_1, locale: customer_1.locale) }
    let!(:complaint_5) { create(:complaint, company: company_3, customer: customer_2, locale: customer_2.locale) }

    subject { ::Queries::ComplaintQuery }

    context 'when pass {}' do
      it { expect(subject.call({}).count).to eq 6 }
    end

    context 'when pass company_id' do
      it { expect(subject.call({company_id: company_1.id}).count).to eq 3 }
      it { expect(subject.call({company_id: company_1.id})).to include complaint_1 }
      it { expect(subject.call({company_id: company_1.id})).to include complaint_1_1 }
      it { expect(subject.call({company_id: company_1.id})).to include complaint_2 }
    end

    context 'when pass customer_id' do
      it { expect(subject.call({customer_id: customer_2.id}).count).to eq 2 }
      it { expect(subject.call({customer_id: customer_2.id})).to include complaint_2 }
      it { expect(subject.call({customer_id: customer_2.id})).to include complaint_5 }
    end

    context 'when pass company_id and customer_id' do
      it { expect(subject.call({company_id: company_1.id, customer_id: customer_1.id}).count).to eq 2 }
      it { expect(subject.call({company_id: company_1.id, customer_id: customer_1.id})).to include complaint_1 }
      it { expect(subject.call({company_id: company_1.id, customer_id: customer_1.id})).to include complaint_1_1 }
    end

    context 'when pass company_id, customer_id and locale' do
      it { expect(subject.call({company_id: company_1.id, customer_id: customer_1.id, locale: 'Maceió'}).count).to eq 2 }
      it { expect(subject.call({company_id: company_1.id, customer_id: customer_1.id, locale: 'Maceió'})).to include complaint_1 }
      it { expect(subject.call({company_id: company_1.id, customer_id: customer_1.id, locale: 'Maceió'})).to include complaint_1_1 }
    end

    context 'when pass company_id and locale' do
      it { expect(subject.call({company_id: company_2.id, locale: 'Maceió'}).count).to eq 1 }
      it { expect(subject.call({company_id: company_2.id, locale: 'Recife'}).count).to eq 1 }
      it { expect(subject.call({company_id: company_2.id, locale: 'Maceió'})).to include complaint_4 }
      it { expect(subject.call({company_id: company_2.id, locale: 'Recife'})).to include complaint_3 }
    end

    context 'when pass customer_id and locale' do
      it { expect(subject.call({customer_id: customer_1.id, locale: 'Maceió'}).count).to eq 3 }
      it { expect(subject.call({customer_id: customer_1.id, locale: 'Maceió'})).to include complaint_1 }
      it { expect(subject.call({customer_id: customer_1.id, locale: 'Maceió'})).to include complaint_1_1 }
      it { expect(subject.call({customer_id: customer_1.id, locale: 'Maceió'})).to include complaint_4 }
    end

    context 'when pass locale' do
      it { expect(subject.call({locale: 'Maceió'}).count).to eq 5 }
      it { expect(subject.call({locale: 'Recife'}).count).to eq 1 }
      it { expect(subject.call({locale: 'Maceió'})).to include complaint_1 }
      it { expect(subject.call({locale: 'Maceió'})).to include complaint_1_1 }
      it { expect(subject.call({locale: 'Maceió'})).to include complaint_2 }
      it { expect(subject.call({locale: 'Recife'})).to include complaint_3 }
      it { expect(subject.call({locale: 'Maceió'})).to include complaint_4 }
      it { expect(subject.call({locale: 'Maceió'})).to include complaint_5 }
    end

  end
end
