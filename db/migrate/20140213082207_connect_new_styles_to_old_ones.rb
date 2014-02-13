class ConnectNewStylesToOldOnes < ActiveRecord::Migration
  def change
    Beer.all.each{ |b| b.update_attribute(:style_id, Style.find_by(name:b.old_style).id) }
  end
end
