class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :only_user_id, presence: true
  validate :validate_picture

  def resize_picture
    return self.picture.variant(resize: "200*200").processed
  end

  private

  def only_user_id
    time.presence or content.presence or picture.attached?
  end

  def validate_picture
    if picture.attached?
      if !picture.content_type.in?(%('image/jpeg image/jpg image/png image/gif'))
        errors.add(:picture, "format error occured. please choose jpg,png or gif.")
      elsif picture.blob.byte_size > 5.megabytes
        errors.add(:picture, "Please less than 5MB.")
      end
    end
  end
end
