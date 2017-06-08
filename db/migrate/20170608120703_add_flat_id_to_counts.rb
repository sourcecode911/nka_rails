class AddFlatIdToCounts < ActiveRecord::Migration[5.1]
  def change
    change_table :counts do |f|
      f.rename :meter_id, :flat_id
      f.integer :invoice_id
      f.integer :strom
      f.integer :kaltwasser
      f.integer :warmwasser
      f.integer :heizung
      f.integer :gas
    end
  end
end
