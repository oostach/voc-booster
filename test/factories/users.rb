# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    middle_name { Faker::Name.middle_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    gender { [1, 5, 10].sample }
    occupation { Faker::Job.title }
    password { 'testtest' }
    password_confirmation { 'testtest' }
    confirmation_token { nil }
  end
end
