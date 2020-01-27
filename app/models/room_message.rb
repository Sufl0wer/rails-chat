class RoomMessage < ApplicationRecord
  belongs_to :room, inverse_of: :room_messages

  belongs_to :user

  has_one_attached :image, dependent: :purge

  def as_json(options)
    if self.image.attached?
      super(options).merge(user_avatar_url: user.gravatar_url,
                           username: user.username,
                           image_url: Rails.application.routes.url_helpers.rails_blob_url(self.image, only_path: true))
    else
      super(options).merge(user_avatar_url: user.gravatar_url,
                           username: user.username)
    end
  end
end
