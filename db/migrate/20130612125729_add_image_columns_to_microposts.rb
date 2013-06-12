class AddImageColumnsToMicroposts < ActiveRecord::Migration
  def change
     add_attachment :microposts, :image
  end
end
