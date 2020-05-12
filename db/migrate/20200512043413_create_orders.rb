class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime "ordered_at"
      t.bigint "user_id"
      t.datetime "delivered_at"
    end
  end
end
