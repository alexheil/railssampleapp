class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :genre, :string
    add_column :users, :biography, :string
    add_column :users, :sounds_like, :string
    add_column :users, :members, :string
  end
end
