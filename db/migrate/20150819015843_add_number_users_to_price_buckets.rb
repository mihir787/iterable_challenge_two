class AddNumberUsersToPriceBuckets < ActiveRecord::Migration
  def change
    add_column :price_buckets, :number_users, :integer
  end
end
