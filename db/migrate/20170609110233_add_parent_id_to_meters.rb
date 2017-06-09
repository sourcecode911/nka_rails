class AddParentIdToMeters < ActiveRecord::Migration[5.1]
  def change
    change_table :meters do |f|
      f.belongs_to :meter, index: true
    end
  end
end
