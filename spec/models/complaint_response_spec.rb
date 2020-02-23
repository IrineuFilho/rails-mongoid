# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ComplaintResponse, type: :model do
  describe 'described_class should be' do
    it_behaves_like 'a mongoid_document', described_class
  end

  describe 'instance custom methods' do
    subject { build(:complaint_response) }
    it { expect(subject.respond_to?(:owner)).to be }
  end

  describe 'owner method return corrent owner association' do
    let(:customer) { create(:customer) }
    let(:company) { create(:company) }
    let(:complaint) { create(:complaint, customer: customer, company: company) }

    context 'when owner of complaint response is a Customer' do
      subject { create(:complaint_response, complaint: complaint, owner: customer) }
      it { expect(subject.owner).to eq(customer) }
      it { expect(subject.owner.class).to be(Customer) }
    end

    context 'when owner of complaint response is a Company' do
      subject { create(:complaint_response, complaint: complaint, owner: company) }
      it { expect(subject.owner).to eq(company) }
      it { expect(subject.owner.class).to be(Company) }
    end
  end

  describe 'list attributes' do
    it_behaves_like 'number attributes on class', described_class, 6

    it { is_expected.to have_timestamps }
    it { is_expected.to have_field('_id').of_type(BSON::ObjectId) }
    it { is_expected.to have_field(:response_text).of_type(String) }
    it { is_expected.to have_field(:owner_id).of_type(String) }
    it { is_expected.to have_field(:owner_type).of_type(String) }
  end

  describe 'list associations' do
    it_behaves_like 'number relations on class', described_class, 1

    it { is_expected.to be_embedded_in(:complaint) }
  end
end
