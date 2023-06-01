# frozen_string_literal: true

RSpec.describe 'doctor left recomendation', type: :feature do
  let(:phone_number) { '+38099887766' }
  let(:password)     { 'password' }
  let!(:doctor) { create(:doctor, password: password, phone_number: phone_number) }
  let!(:appointment) { create(:appointment, doctor: doctor, appointment_date: 2.days.ago) }

  it 'signs me in' do
    visit '/'

    within('#new_user') do
      fill_in 'Phone number', with: phone_number
      fill_in 'Password', with: password
    end

    click_button 'Log in'

    expect(page).to have_content 'You can make appointment right here'
  end

  it 'make recomedation' do
    visit '/'

    within('#new_user') do
      fill_in 'Phone number', with: phone_number
      fill_in 'Password', with: password
    end

    click_button 'Log in'

    visit 'appointments'

    find("#wait_for_recomendation_#{appointment.id}").click

    click_link 'Update appointment'

    within("#edit_appointment_#{appointment.id}") do
      fill_in 'Recomendation', with: 'Take more vitamins and go for a walk outside!'
    end

    click_button 'Update appointment'

    expect(page).to have_content 'Take more vitamins and go for a walk outside!'
    expect(current_path).to eq(appointment_path(appointment))
  end
end
