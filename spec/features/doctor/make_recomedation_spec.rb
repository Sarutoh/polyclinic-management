# frozen_string_literal: true

RSpec.describe 'doctor left recomendation', type: :feature do
  let(:phone_number) { '998877660' }
  let(:password)     { 'password' }
  let!(:doctor) { create(:doctor, password: password, phone_number: phone_number) }
  let!(:appointment) do
    create(:appointment, doctor: doctor, time_slot: create(:time_slot, :passed))
  end
  let(:recomendation) { 'Take more vitamins and go for a walk outside!' }

  it 'makes recomendation' do
    login_user(phone_number, password)

    visit 'appointments'

    find("#wait_for_recomendation_#{appointment.id}").click

    click_link 'Update appointment'

    within("#edit_appointment_#{appointment.id}") do
      fill_in 'Recomendation', with: recomendation
    end

    expect { click_button('Update appointment') }.to change { appointment.reload.recomendation }
      .from('').to(recomendation)

    expect(page).to have_content(recomendation)
    expect(page).to have_current_path(appointment_path(appointment))
  end
end
