# frozen_string_literal: true

class AddStatusToMatch < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :status, :integer, default: 0
  end
end
