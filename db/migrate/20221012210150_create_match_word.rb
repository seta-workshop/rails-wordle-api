# frozen_string_literal: true

class CreateMatchWord < ActiveRecord::Migration[7.0]
  def change
    create_table :match_words do |t|

      t.timestamps
    end
  end
end
