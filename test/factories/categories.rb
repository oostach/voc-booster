# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    rule { Faker::Lorem.paragraph }
  end
end
