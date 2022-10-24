# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :victories
      t.integer :losses
      t.integer :streak
      t.integer :best_streak
      t.timestamps
    end
  end
end
