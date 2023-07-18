# frozen_string_literal: true

class Expression < ApplicationRecord
  belongs_to :language, inverse_of: :expressions
  belongs_to :category, inverse_of: :expressions

  validates :content, presence: true
end
