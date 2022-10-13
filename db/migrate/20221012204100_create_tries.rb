# frozen_string_literal: true

class CreateTries < ActiveRecord::Migration[7.0]
  def change
    create_table :tries do |t|
      t.numeric :count
      t.text :letters, array: true, default: []
      t.text :letters_colours, array: true, default: []
      t.references :user
      t.references :match
      t.timestamps
    end
  end
end
