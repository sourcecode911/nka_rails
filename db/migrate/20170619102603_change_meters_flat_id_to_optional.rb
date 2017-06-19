class ChangeMetersFlatIdToOptional < ActiveRecord::Migration[5.1]
  def change
    change_column_null :meters, :flat_id, true
  end
end
