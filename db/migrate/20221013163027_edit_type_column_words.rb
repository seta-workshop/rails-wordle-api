# frozen_string_literal: true

class EditTypeColumnWords < ActiveRecord::Migration[7.0]
  def change
    rename_column(:words, :type, :kind)
  end
end
