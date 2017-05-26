class AddExpenseTypeToMeters < ActiveRecord::Migration[5.1]
  def change
    change_table :meters do |f|
      f.integer :expense_type
      f.integer :user_id
    end
  end
end
