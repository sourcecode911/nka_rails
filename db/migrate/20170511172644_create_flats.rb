class CreateFlats < ActiveRecord::Migration[5.1]
  def change
    create_table :flats do |t|
      t.integer :area, null: false
      t.integer :tax, null: false
      t.integer :ownership
      t.integer :state, default: 1, null: false

      t.timestamps
    end
  end
end
