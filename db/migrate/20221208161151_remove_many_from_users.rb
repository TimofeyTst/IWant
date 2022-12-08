class RemoveManyFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email
    remove_column :users, :password_digest
    remove_column :users, :last_login
  end
end
