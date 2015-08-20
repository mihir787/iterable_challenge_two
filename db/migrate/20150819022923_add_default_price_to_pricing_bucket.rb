class AddDefaultPriceToPricingBucket < ActiveRecord::Migration
  def change
    change_column :price_buckets, :price, :integer, default: 10
  end
end
