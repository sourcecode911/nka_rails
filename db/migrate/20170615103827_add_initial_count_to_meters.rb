class AddInitialCountToMeters < ActiveRecord::Migration[5.1]
  def change
    add_column :meters, :initial_count, :decimal
  end
end
