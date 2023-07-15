# frozen_string_literal: true

class Vocabulary < ApplicationRecord
  belongs_to :user
  has_many :records, dependent: :destroy
  has_many :expressions, through: :records
  belongs_to :language, inverse_of: :vocabulary
end
