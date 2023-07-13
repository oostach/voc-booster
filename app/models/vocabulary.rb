# frozen_string_literal: true

class Vocabulary < ApplicationRecord
  belongs_to :user
  belongs_to :words

end
