class AddThemeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :theme, :integer, default: 1
  end
end
