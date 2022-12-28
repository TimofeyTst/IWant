class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :name
      t.integer :initiator_id, null: false, foreign_key: true
      t.integer :recipient_id, null: false, foreign_key: true

      t.timestamps
    end

    remove_column :messages, :room_id, null: false, foreign_key: true
    add_column :messages, :chat_id, :integer, null: false, foreign_key: true
  end
end
