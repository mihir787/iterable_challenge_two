class AddDefaultToPricingBucket < ActiveRecord::Migration
  def change
    change_column :price_buckets, :number_users, :integer, default: 0
  end
end
