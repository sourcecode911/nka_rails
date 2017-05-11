class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.integer :user_id, null: false
      t.integer :year, null: false
      t.integer :state, default: 1, null: false

      t.timestamps
    end
  end
end
