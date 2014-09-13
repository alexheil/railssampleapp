class AddActivationToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :activation_digest, :string
    add_column :artists, :activated, :boolean, default: false
    add_column :artists, :activated_at, :datetime
  end
end
