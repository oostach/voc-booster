# frozen_string_literal: true

FactoryBot.define do
  factory :vocabulary do
    association :user
    association :language
  end
end
