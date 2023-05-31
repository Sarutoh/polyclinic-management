# frozen_string_literal: true

LOGIN_IMAGE_URL = 'https://res.cloudinary.com/dao7yd35p/image/upload/v1685446452/general/login_image2_aruprc.jpg'
DEFAULT_PROFILE_IMAGE = 'https://res.cloudinary.com/dao7yd35p/image/upload/v1665059701/general/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR_q7x5nk.jpg'
AVATAR_SIZE = 40
EDIT_AVATAR_SIZE = 150

module ApplicationHelper
  def avatar
    if current_user.avatar.attached?
      image_tag(AVATAR_SIZE,
                current_user.avatar.url)
    else
      image_tag(AVATAR_SIZE, DEFAULT_PROFILE_IMAGE)
    end
  end

  def edit_avatar
    if current_user.avatar.attached?
      image_tag(EDIT_AVATAR_SIZE,
                current_user.avatar.url)
    else
      image_tag(EDIT_AVATAR_SIZE,
                DEFAULT_PROFILE_IMAGE)
    end
  end

  def participant(appointment)
    if current_user.doctor?
      safe_join([tag.div('Patient'), tag.strong(appointment.patient.full_name.to_s)])
    else
      safe_join([tag.div('Doctor'), tag.strong(appointment.doctor.full_name.to_s)])
    end
  end

  def able_to_recomendate?(appointment)
    appointment.appointment_date.past? && !appointment.closed
  end

  private

  def image_tag(avatar_size, url)
    tag.img src: url, class: 'rounded-pill d-block mr-1', width: avatar_size, height: avatar_size
  end
end
