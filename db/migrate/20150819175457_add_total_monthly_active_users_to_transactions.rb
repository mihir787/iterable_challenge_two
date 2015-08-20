class AddTotalMonthlyActiveUsersToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :total_monthly_active_users, :integer
  end
end
