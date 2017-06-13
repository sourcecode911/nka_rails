class AddFieldsToInvoiceDetails < ActiveRecord::Migration[5.1]
  def change
    change_table :invoice_details do |t|
      t.decimal :kaltwasser
      t.decimal :warmwasser
      t.decimal :heizung
      t.decimal :strom
      t.decimal :abfall
      t.decimal :versicherung
      t.decimal :steuer
      t.decimal :niederschlag
    end
  end

  remove_column :invoice_details, :amount
end
