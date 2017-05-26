class AddCurrentInvoiceIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_invoice_id, :integer
  end
end
