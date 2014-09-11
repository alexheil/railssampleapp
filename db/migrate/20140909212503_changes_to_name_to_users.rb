class ChangesToNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :artist_name, :string
    rename_column :users, :name, :username
  end
end
