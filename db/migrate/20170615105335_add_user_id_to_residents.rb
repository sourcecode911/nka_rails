class AddUserIdToResidents < ActiveRecord::Migration[5.1]
  def change
    add_reference :residents, :user, foreign_key: true
  end
end
