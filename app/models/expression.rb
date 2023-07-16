# frozen_string_literal: true

class Expression < ApplicationRecord
  belongs_to :language, inverse_of: :expression
  belongs_to :category, inverse_of: :expression
end
