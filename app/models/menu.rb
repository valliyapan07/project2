class Menu < ActiveRecord::Base
  has_many :menu_items
  $vvv

  def display_menu
    "#{name}"
  end

  def self.activemenu?
    Menu.find_by(activemenu: true)
  end
end
