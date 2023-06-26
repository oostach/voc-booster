# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :users do |t|
      t.string   :email, null: false, index: { unique: true }
      t.string   :password_digest, null: false

      t.string   :first_name, null: false, limit: 128
      t.string   :last_name, null: false, limit: 128
      t.string   :middle_name, limit: 128

      t.date :date_of_birth
      t.integer  :gender
      t.string   :occupation

      t.timestamps
    end
  end
end
