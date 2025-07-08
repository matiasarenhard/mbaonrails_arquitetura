class CreateCoinLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :coin_logs do |t|
      t.references :coin, null: false, foreign_key: true
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
