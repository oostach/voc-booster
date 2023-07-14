# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :vocabularies, dependent: :destroy

end
