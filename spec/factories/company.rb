# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Name.name }
    cnpj { '12345678' }
    locale { create(:city) }

    trait :without_name do
      name { '' }
    end
  end
end
