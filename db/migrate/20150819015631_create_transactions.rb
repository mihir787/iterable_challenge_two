class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :charge
      t.integer :result, default: 0
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
