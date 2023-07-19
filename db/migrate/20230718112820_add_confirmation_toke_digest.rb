# frozen_string_literal: true

class AddConfirmationTokeDigest < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :confirmation_token_digest
      t.references :language, foreign_key: true
    end
  end
end
