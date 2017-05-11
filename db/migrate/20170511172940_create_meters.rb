class CreateMeters < ActiveRecord::Migration[5.1]
  def change
    create_table :meters do |t|
      t.string :name
      t.integer :flat_id, null: false
      t.integer :state, default: 1, null: false

      t.timestamps
    end
  end
end
