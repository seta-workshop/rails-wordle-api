class AddStatsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :wins, :integer, default: 0
    add_column :users, :losses, :integer, default: 0
    add_column :users, :streak, :integer, default: 0
    add_column :users, :best_streak, :integer, default: 0
  end
end
