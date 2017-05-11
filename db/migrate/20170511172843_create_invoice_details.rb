class CreateInvoiceDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_details do |t|
      t.integer :invoice_id, null: false
      t.integer :expense_id, null: false
      t.integer :resident_id, null: false
      t.decimal :amount
      t.integer :state, default: 1, null: false

      t.timestamps
    end
  end
end
