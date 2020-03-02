# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    name { Faker::Name.name }
    federal_unit { Faker::Name.name }
  end
end
