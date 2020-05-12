class Menuitem < ActiveRecord::Base
  belongs_to :menu
  def self.match(id, category_name)
    Menuitem.all.where("menu_id= ? and category_name= ?", id, category_name.category_name)
  end

  def self.display
    Menuitem.all.each do |t|
      puts t.name
      puts t.description
      puts t.price
      puts t.category_name
      puts t.imgaddr
    end
  end

  def self.category
    Menuitem.select(:category_name).distinct
  end
end
