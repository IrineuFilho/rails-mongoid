# frozen_string_literal: true

FactoryBot.define do
  factory :complaint do
    title { 'Complaint Title' }
    description { 'Complaint Description' }
    locale { create(:city) }
    customer { create(:customer) }
    company { create(:company) }
  end
end
