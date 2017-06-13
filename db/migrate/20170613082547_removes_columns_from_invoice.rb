class RemovesColumnsFromInvoice < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :strompreis
    remove_column :invoices, :stromverbrauch
  end
end
