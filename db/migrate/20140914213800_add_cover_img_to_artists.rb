class AddCoverImgToArtists < ActiveRecord::Migration
  def change
    add_attachment :artists, :cover_img
  end
end
