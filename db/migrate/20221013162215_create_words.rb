# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.integer :kind, default: 0
      t.string :value
      t.timestamps
    end
  end
end
