# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Complaint, type: :model do
  describe 'described_class should be' do
    it_behaves_like 'a mongoid_document', described_class
  end

  describe 'list attributes' do
    it_behaves_like 'number attributes on class', described_class, 5

    it { is_expected.to have_timestamps }
    it { is_expected.to have_field('_id').of_type(BSON::ObjectId) }
    it { is_expected.to have_field(:title).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
  end

  describe 'embed object' do
    it_behaves_like 'embed one object', described_class, :locale
    it_behaves_like 'embed one object', described_class, :customer
    it_behaves_like 'embed one object', described_class, :company
    it_behaves_like 'embeds maby object', described_class, :complaint_responses
  end

  describe 'validations' do
    describe 'presence of' do
      context 'valid' do
        let(:complaint) { attributes_for(:complaint) }
        subject { Complaint.new(complaint) }

        it { expect(subject).to be_valid }
      end

      context 'invalid' do
        context 'without title' do
          let(:complaint) { attributes_for(:complaint, :without_title) }

          subject { Complaint.new(complaint) }

          it { expect(subject).not_to be_valid }
          it 'errors must be populated' do
            subject.valid?
            expect(subject.errors.any?).to be
          end
        end

        context 'without description' do
          let(:complaint) { attributes_for(:complaint, :without_title) }

          subject { Complaint.new(complaint) }

          it { expect(subject).not_to be_valid }
          it 'errors must be populated' do
            subject.valid?
            expect(subject.errors.any?).to be
          end
        end
      end
    end
  end
end
