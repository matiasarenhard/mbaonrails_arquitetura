class CreateCoins < ActiveRecord::Migration[8.0]
  def change
    create_table :coins do |t|
      t.string :name, index: true, null: false
      t.string :symbol, index: true, null: false

      t.timestamps
    end
  end
end
