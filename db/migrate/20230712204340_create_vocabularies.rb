# frozen_string_literal: true

class CreateVocabularies < ActiveRecord::Migration[7.0]
  def change
    create_table :vocabularies do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :language, foreign_key: true, null: false

      t.timestamps
    end
  end
end
