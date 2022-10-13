# frozen_string_literal: true

class AddEmailChangeTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reset_email_token, :string
    add_column :users, :reset_email_sent_at, :datetime
  end
end
