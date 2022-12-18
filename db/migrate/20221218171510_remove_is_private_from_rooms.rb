class RemoveIsPrivateFromRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :is_private, :boolean
  end
end
