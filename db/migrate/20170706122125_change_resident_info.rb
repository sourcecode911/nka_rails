class ChangeResidentInfo < ActiveRecord::Migration[5.1]
  def change
    change_table :residents do |f|
      f.string :first_name
      f.string :last_name
      f.string :street
      f.integer :plz
      f.string :location
      f.string :email
      f.remove :name
    end
  end
end
