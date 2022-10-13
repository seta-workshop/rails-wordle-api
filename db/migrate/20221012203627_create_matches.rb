# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.text :mode
      t.datetime :clock
      t.timestamps
    end
  end
end
