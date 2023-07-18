# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :expressions, dependent: :nullify, inverse_of: :category

  validates :name, :rule, presence: true
end
