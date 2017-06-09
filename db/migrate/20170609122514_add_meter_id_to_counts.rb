class AddMeterIdToCounts < ActiveRecord::Migration[5.1]
  def change
    change_table :counts do |f|
      f.belongs_to :meter, index: true
      f.remove :strom
      f.remove :flat_id
      f.remove :kaltwasser
      f.remove :warmwasser
      f.remove :heizung
      f.remove :gas
    end
  end
end
