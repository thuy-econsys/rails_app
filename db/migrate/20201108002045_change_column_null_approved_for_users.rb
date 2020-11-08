class ChangeColumnNullApprovedForUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :approved, false, false)
  end
end
