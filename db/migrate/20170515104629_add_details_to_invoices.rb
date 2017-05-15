class AddDetailsToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :erdgas, :decimal
    add_column :invoices, :kamin, :decimal
    add_column :invoices, :wartung, :decimal
    add_column :invoices, :reinigung, :decimal
    add_column :invoices, :strom, :decimal
    add_column :invoices, :gesamt_strom, :decimal
    add_column :invoices, :wasser, :decimal
    add_column :invoices, :abwasser, :decimal
    add_column :invoices, :niederschlag, :decimal
    add_column :invoices, :abfall, :decimal
    add_column :invoices, :grundsteuer, :decimal
    add_column :invoices, :versicherung, :decimal
  end
end
