class AddDeletedAtToCoins < ActiveRecord::Migration[8.0]
  def change
    add_column :coins, :deleted_at, :datetime, null: true, default: nil
    add_index :coins, :deleted_at
  end
end
