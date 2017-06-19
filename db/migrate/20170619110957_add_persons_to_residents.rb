class AddPersonsToResidents < ActiveRecord::Migration[5.1]
  def change
    add_column :residents, :persons, :integer
  end
end
