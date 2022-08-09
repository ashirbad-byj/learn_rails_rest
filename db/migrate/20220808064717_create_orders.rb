class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.belongs_to :item, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
