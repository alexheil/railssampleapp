class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.integer :artist_id

      t.timestamps
    end
    add_index :microposts, [:artist_id, :created_at]
  end
end
