# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :users do |t|
      t.string   :email, null: false
      t.string   :password, null: false, limit: 64
      t.string   :password_confirmation, null: false, limit: 64

      t.string   :first_name, null: false, limit: 128
      t.string   :last_name, null: false, limit: 128
      t.string   :middle_name, limit: 128

      t.datetime :date_of_birth
      t.integer  :gender
      t.string   :occupation

      t.timestamps
    end
  end
end
