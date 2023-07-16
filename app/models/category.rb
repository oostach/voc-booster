# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :expression, dependent: :destroy, inverse_of: :category

  validates :name, :rule, presence: true
end
