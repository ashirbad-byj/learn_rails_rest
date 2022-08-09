class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null:false
      t.integer :age, null:false
      t.integer :status, null:false, :default=> 1

      t.timestamps
    end
  end
end
