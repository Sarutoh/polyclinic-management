# frozen_string_literal: true

module LoginHelper
  def login_user(phone_number, password)
    visit '/'

    within('#new_user') do
      fill_in 'Phone number', with: phone_number
      fill_in 'Password', with: password
    end

    click_button 'Log in'
  end
end
