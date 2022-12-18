class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.integer :initiator_id, null: false
      t.integer :recipient_id, null: false
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
