# frozen_string_literal: true

FactoryBot.define do
  factory :vocabulary do
    user { association :user }
    language { association :language }
  end
end
