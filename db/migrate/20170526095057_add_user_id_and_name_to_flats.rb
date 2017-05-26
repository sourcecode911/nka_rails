class AddUserIdAndNameToFlats < ActiveRecord::Migration[5.1]
  def change
    change_table :flats do |f|
      f.string :name, after: :ownership
      f.integer :user_id, after: :name
    end
  end
end
