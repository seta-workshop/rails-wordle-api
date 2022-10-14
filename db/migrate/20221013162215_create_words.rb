# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.integer :kind
      t.text :value
      t.timestamps
    end
  end
end
