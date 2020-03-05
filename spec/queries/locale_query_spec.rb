# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::LocaleQuery, type: :query do
  describe 'responto_to method call' do
    context do
      it { expect(described_class.respond_to?(:call)).to be }
    end
  end

  describe 'return result' do
    let!(:city_1) { create(:city, name: 'Maceió') }
    let!(:city_2) { create(:city, name: 'Santana') }
    let!(:city_3) { create(:city, name: 'São Paulo') }
    subject { ::Queries::LocaleQuery }

    it { expect(subject.call('Recife').count).to eq(0) }
    it { expect(subject.call('Mac').count).to eq(1) }
    it { expect(subject.call('Mac')).to include(city_1) }
    it { expect(subject.call('Maceió').count).to eq(1) }
    it { expect(subject.call('Maceió')).to include(city_1) }
  end
end
