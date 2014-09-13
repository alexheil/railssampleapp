class Micropost < ActiveRecord::Base
  belongs_to :artist
  default_scope -> { order('created_at DESC') }
  validates :artist_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
