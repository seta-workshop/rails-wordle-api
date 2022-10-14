# frozen_string_literal: true

class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.integer :count, default: 0
      t.text :letters, array: true, default: []
      t.text :letters_colours, array: true, default: []
      t.references :user
      t.references :match
      t.timestamps
    end
  end
end
