class CreateResidents < ActiveRecord::Migration[5.1]
  def change
    create_table :residents do |t|
      t.string :name
      t.date :move_in
      t.date :move_out
      t.integer :flat_id, null: false
      t.integer :state, default: 1, null: false

      t.timestamps
    end
  end
end
