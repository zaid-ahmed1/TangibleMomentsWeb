class Memory < ApplicationRecord
  has_one_attached :video
  belongs_to :user

  validates :title, presence: true
  validates :video, presence: true
end
