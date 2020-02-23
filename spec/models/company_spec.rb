# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'described_class should be' do
    it_behaves_like 'a mongoid_document', described_class
  end

  describe 'list attributes' do
    it_behaves_like 'number attributes on class', described_class, 4
    it { is_expected.to have_field(:_id).of_type(BSON::ObjectId) }
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:cnpj).of_type(String) }
    it { is_expected.to have_field(:city_id).of_type(Object) }
  end

  describe 'list associations' do
    it_behaves_like 'number relations on class', described_class, 2

    it { is_expected.to belong_to(:city).with_foreign_key(:city_id).as_inverse_of(:company) }
    it { is_expected.to have_many(:complains).as_inverse_of(:company).with_dependent(:destroy) }
  end
end
