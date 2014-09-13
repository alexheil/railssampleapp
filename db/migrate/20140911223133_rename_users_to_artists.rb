class RenameUsersToArtists < ActiveRecord::Migration
  def change
    rename_table :users, :artists
  end
end
