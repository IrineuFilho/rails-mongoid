# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Complaint, type: :model do
  describe 'described_class should be' do
    it_behaves_like 'a mongoid_document', described_class
  end

  describe 'list attributes' do
    it_behaves_like 'number attributes on class', described_class, 8

    it { is_expected.to have_timestamps }
    it { is_expected.to have_field('_id').of_type(BSON::ObjectId) }
    it { is_expected.to have_field(:title).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:customer_id).of_type(Object) }
    it { is_expected.to have_field(:company_id).of_type(Object) }
    it { is_expected.to have_field(:locale_id).of_type(Object) }
  end

  describe 'list associations' do
    it_behaves_like 'number relations on class', described_class, 4

    it { is_expected.to belong_to(:customer).as_inverse_of(:complaint) }
    it { is_expected.to belong_to(:company).as_inverse_of(:complaint) }
    it { is_expected.to embed_many(:complaint_responses) }
    it { is_expected.to belong_to(:locale).with_foreign_key(:locale_id).as_inverse_of(:complaint) }
  end
end
