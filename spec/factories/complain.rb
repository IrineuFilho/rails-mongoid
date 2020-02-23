# frozen_string_literal: true

FactoryBot.define do
  factory :complain do
    title { 'Complain Title' }
    description { 'Complain Description' }
    locale { create(:city) }
    customer { create(:customer) }
    company { create(:company) }
  end
end
