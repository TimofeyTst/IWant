class RemoveRoomsAndParticipants < ActiveRecord::Migration[7.0]
  def change
    drop_table :participants
    drop_table :rooms
  end
end
