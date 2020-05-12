class CreateMenuitems < ActiveRecord::Migration[6.0]
  def change
    create_table :menuitems do |t|
      t.bigint "menu_id"
      t.string "name"
      t.text "description"
      t.float "price"
      t.string "category_name"
      t.text "imgaddr"
    end
  end
end
