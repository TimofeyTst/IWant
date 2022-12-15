class CreateCollectionSavedPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :collection_saved_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
