class AddDetailsToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :location, :string
    add_column :artists, :genre, :string
    add_column :artists, :biography, :string
    add_column :artists, :sounds_like, :string
    add_column :artists, :members, :string
  end
end
