# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Name.name }
    cnpj { '12345678' }
    city { create(:city) }
  end
end
