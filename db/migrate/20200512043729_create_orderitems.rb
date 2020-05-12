class CreateOrderitems < ActiveRecord::Migration[6.0]
  def change
    create_table :orderitems do |t|
      t.bigint "order_id"
      t.bigint "menuitem_id"
      t.string "menuitem_name"
      t.float "menuitem_price"
      t.integer "menuitem_quantity"
    end
  end
end
