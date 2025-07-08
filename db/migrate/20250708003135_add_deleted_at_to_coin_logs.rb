class AddDeletedAtToCoinLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :coin_logs, :deleted_at, :datetime, null: true
  end
end
