# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }

    trait :without_name do
      name { '' }
    end

    trait :without_email do
      email { '' }
    end
  end
end
