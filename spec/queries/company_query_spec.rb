# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::CompanyQuery, type: :query do
  describe 'responto_to method call' do
    context do
      it { expect(described_class.respond_to?(:call)).to be }
    end
  end

  describe 'return result' do
    let!(:company_1) { create(:company, name: 'Company A', cnpj: '2') }
    let!(:company_2) { create(:company, name: 'Company B', cnpj: '3') }

    context 'without any parameters to filter' do
      it 'should return all companies' do
        expect(described_class.call({}).count).to eq(2)
      end

      it 'result should be a Mongoid::Contextual::Mongo' do
        expect(described_class.call({}).class).to eq(Mongoid::Contextual::Mongo)
      end
    end

    context 'with parameter filter name or cnpj' do
      it 'when pass name as parameter, result count should be 1' do
        expect(described_class.call({ name: company_1.name }).count).to eq(1)
      end

      it 'when pass a part name as parameter, result count should be 1' do
        expect(described_class.call({ name: 'compa' }).count).to eq(2)
      end

      it 'when pass name as parameter, result should include the company' do
        expect(described_class.call({ name: company_1.name }).include?(company_1)).to be
      end

      it 'when pass cnpj as parameter, result count should be 1' do
        expect(described_class.call({ cnpj: company_1.cnpj }).count).to eq(1)
      end

      it 'when pass cnpj as parameter, result should include the company' do
        expect(described_class.call({ cnpj: company_1.cnpj }).count).to eq(1)
      end

      it 'when exist more than one company with passed parameters, result should contain the companies' do
        expect(described_class.call({ name: company_1.name, cnpj: company_1.cnpj }).include?(company_1)).to be
        expect(described_class.call({ name: company_2.name, cnpj: company_2.cnpj }).include?(company_2)).to be
      end

      it 'when pass a company name or company cnpj that doesn\'t exist, result count should be 0' do
        expect(described_class.call({ name: 'does not exist', cnpj: 'does not exist' }).count).to eq(0)
      end
    end

    context 'with parameter order by' do
      let!(:company_3) { create(:company, name: 'Company C', cnpj: '1') }

      it 'when pass order_by \'name\', first result should be company_1' do
        expect(described_class.call({ name: 'company' }, order_by: 'name').first).to eq(company_1)
      end

      it 'when pass order_by \'cnpj\', first result should be company_1' do
        expect(described_class.call({ name: 'company' }, order_by: 'cnpj').first).to eq(company_3)
      end
    end

    context 'with parameter direction' do
      it 'when pass direction \'ASC\' or \'asc\', first result should be company_1' do
        expect(described_class.call({ name: 'Company' }, direction: 'asc').first).to eq(company_1)
      end

      it 'when pass direction \'DESC\' or \'desc\', first result should be company_2' do
        expect(described_class.call({ name: 'company' }, direction: 'desc').first).to eq(company_2)
      end
    end

    context 'with parameter direction invalid' do
      it { expect { described_class.call({ name: 'Company' }, direction: 'ASC') }.to raise_error(::Exceptions::BadRequestException) }
      it { expect { described_class.call({ name: 'Company' }, direction: 'Asc') }.to raise_error(::Exceptions::BadRequestException) }
      it { expect { described_class.call({ name: 'Company' }, direction: 'DESC') }.to raise_error(::Exceptions::BadRequestException) }
      it { expect { described_class.call({ name: 'Company' }, direction: 'Desc') }.to raise_error(::Exceptions::BadRequestException) }
    end
  end
end
