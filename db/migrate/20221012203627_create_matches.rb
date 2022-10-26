# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :mode, default: 0
      t.datetime :finished_at
      t.references :user
      t.references :word
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
