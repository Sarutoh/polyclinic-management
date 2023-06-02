# frozen_string_literal: true

class ImagesPresenter < BasePresenter
  include ActionView::Helpers::TagHelper

  URL_PREFIX = 'https://res.cloudinary.com/dao7yd35p/image/upload'
  LOGIN_IMAGE_URL = "#{URL_PREFIX}/v1685446452/general/login_image2_aruprc.jpg".freeze
  DEFAULT_AVATAR_URL = "#{URL_PREFIX}/v1665059701/general/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR_q7x5nk.jpg"
                       .freeze

  SIZES = {
    avatar: 40,
    edit_avatar: 150
  }.freeze

  def avatar(params)
    size = SIZES[params[:type]]
    user = params[:user]

    if user.avatar.attached?
      image_tag(size, user.avatar.url)
    else
      image_tag(size, DEFAULT_AVATAR_URL)
    end
  end

  private

  def image_tag(avatar_size, url)
    tag.img src: url, class: 'rounded-pill d-block mr-1', width: avatar_size, height: avatar_size
  end
end
