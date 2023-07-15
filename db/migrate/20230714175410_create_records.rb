# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.belongs_to :vocabulary, foreign_key: true, null: false
      t.belongs_to :expression, foreign_key: true, null: false

      t.timestamps
    end
  end
end
