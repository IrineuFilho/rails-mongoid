# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'described_class should be' do
    it_behaves_like 'a mongoid_document', described_class
  end

  describe 'list attributes' do
    it_behaves_like 'number attributes on class', described_class, 4
    it_behaves_like 'include attributes on class', described_class, '_id'
    it_behaves_like 'include attributes on class', described_class, 'name'
    it_behaves_like 'include attributes on class', described_class, 'cnpj'
    it_behaves_like 'include attributes on class', described_class, 'city_id'
  end
end
