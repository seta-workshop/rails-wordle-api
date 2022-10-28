class AddStatsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :wins, :integer
    add_column :users, :losses, :integer
    add_column :users, :streak, :integer
    add_column :users, :best_streak, :integer
  end
end
