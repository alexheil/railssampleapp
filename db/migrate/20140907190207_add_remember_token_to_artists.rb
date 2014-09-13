class AddRememberTokenToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :remember_digest, :string
  end
end
