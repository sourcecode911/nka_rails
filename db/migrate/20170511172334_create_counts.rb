class CreateCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :counts do |t|
      t.integer :meter_id, null: false
      t.decimal :amount, null: false
      t.date :date, null: false
      t.integer :state, default: 1, null: false

      t.timestamps
    end
  end
end
