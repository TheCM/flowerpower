class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order_id
      t.belongs_to :product_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
