class Menu < ActiveRecord::Base
  has_many :menu_items

  def display_menu
    "#{name}"
  end

  def self.activemenu?
    Menu.find_by(activemenu: true)
  end

  def self.display
    Menu.all
  end

  def self.activemenu
    menu = Menu.find_by(activemenu: true)
    menu ? menu.name : "Not Selected"
  end
end
