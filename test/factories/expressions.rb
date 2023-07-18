# frozen_string_literal: true

FactoryBot.define do
  factory :expression do
    content { Faker::Lorem.word }
    meaning { Faker::Lorem.paragraph }
    language { association :language }
    category { association :category }
  end
end
