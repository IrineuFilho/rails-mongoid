# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'described_class should be' do
    it_behaves_like 'a mongoid_document', described_class
  end

  describe 'list attributes' do
    it_behaves_like 'number attributes on class', described_class, 5

    it { is_expected.to have_timestamps }
    it { is_expected.to have_field('_id').of_type(BSON::ObjectId) }
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:email).of_type(String) }
  end

  describe 'embed objects' do
    it_behaves_like 'embed one object', described_class, :locale
  end

  describe 'validations' do
    context 'valid' do
      subject { build(:customer) }
      it { expect(subject).to be_valid }
    end

    context 'presence of name' do
      context 'invalid' do
        subject { build(:customer, :without_name) }
        it { expect(subject).not_to be_valid }
      end
    end

    context 'presence of email' do
      context 'invalid' do
        subject { build(:customer, :without_email) }
        it { expect(subject).not_to be_valid }
      end
    end
  end
end
