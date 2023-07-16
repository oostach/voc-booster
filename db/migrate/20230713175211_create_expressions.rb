# frozen_string_literal: true

class CreateExpressions < ActiveRecord::Migration[7.0]
  def change
    create_table :expressions do |t|
      t.belongs_to :language, foreign_key: true, null: false
      t.belongs_to :category

      t.string :content, null: false
      t.string :meaning

      t.timestamps
    end
  end
end
