# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :vocabulary, inverse_of: :record
  belongs_to :expression, inverse_of: :record
end
