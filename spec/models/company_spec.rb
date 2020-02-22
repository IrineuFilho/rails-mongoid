require 'rails_helper'

RSpec.describe Company, type: :model do

  describe 'teste' do

    let(:company) { create(:company) }

    it { expect(subject).to be_mongoid_document }
    it { expect(company).to be_persisted }

  end

end