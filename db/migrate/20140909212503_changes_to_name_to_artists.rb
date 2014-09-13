class ChangesToNameToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :artist_name, :string
    rename_column :artists, :name, :username
  end
end
