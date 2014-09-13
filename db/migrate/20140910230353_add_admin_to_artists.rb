class AddAdminToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :admin, :boolean, default: false
  end
end
