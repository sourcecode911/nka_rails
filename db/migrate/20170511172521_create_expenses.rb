class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :invoice_id, null: false
      t.decimal :amount, null: false
      t.integer :cost_type, null: false
      t.integer :state, default: 1, null: false

      t.timestamps
    end
  end
end
