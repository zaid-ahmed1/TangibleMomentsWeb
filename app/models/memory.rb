class Memory < ApplicationRecord
  has_one_attached :video
  belongs_to :user
  after_save :store_video_key, if: -> { video.attached? }

  validates :title, presence: true
  validates :video, presence: true

  def store_video_key
    update_column(:filekey, video.blob.key)
  end

end
