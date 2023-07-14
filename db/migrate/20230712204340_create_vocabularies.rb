# frozen_string_literal: true

class CreateVocabularies < ActiveRecord::Migration[7.0]
  def change
    create_table :vocabularies do |t|
      t.belongs_to :user
      t.belongs_to :language

      t.timestamps
    end
  end
end
