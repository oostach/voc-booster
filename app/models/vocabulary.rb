# frozen_string_literal: true

class Vocabulary < ApplicationRecord
  belongs_to :user, inverse_of: :vocabularies
  belongs_to :language, inverse_of: :vocabularies
  has_many :records, dependent: :destroy, inverse_of: :vocabulary
  has_many :expressions, through: :records
end
