class CreateLikeables < ActiveRecord::Migration[7.0]
  def change
    create_table :likeables do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
