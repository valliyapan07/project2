class CreateCartitems < ActiveRecord::Migration[6.0]
  def change
    create_table :cartitems do |t|
      t.string "name"
      t.float "price"
      t.integer "quantity"
      t.bigint "menuitem_id"
      t.bigint "user_id"
    end
  end
end
