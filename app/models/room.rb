class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :name

  def self.create_room(current_user, user, room_name)
    single_room = Room.create(name: room_name)
    Participant.create(initiator_id: current_user.id, recipient_id: user.id, room_id: single_room.id)
    single_room
  end
end
