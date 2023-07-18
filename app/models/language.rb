# frozen_string_literal: true

class Language < ApplicationRecord
  AVAILABLE_LANGUAGES = %i[ukrainian english].freeze

  has_many :vocabularies, dependent: :destroy, inverse_of: :language
  has_many :expressions, dependent: :destroy, inverse_of: :language

  validates :name, presence: true
end
