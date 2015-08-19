class CreatePriceBuckets < ActiveRecord::Migration
  def change
    create_table :price_buckets do |t|
      t.integer :price
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
