class AddExpenseTypeToMeters < ActiveRecord::Migration[5.1]
  def change
    add_column :meters, :expense_type, :integer
  end
end
