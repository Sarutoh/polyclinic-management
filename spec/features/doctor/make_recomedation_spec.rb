# frozen_string_literal: true

RSpec.describe 'doctor left recomendation', type: :feature do
  let(:phone_number) { '+38099887766' }
  let(:password)     { 'password' }
  let!(:doctor) { create(:doctor, password: password, phone_number: phone_number) }
  let!(:appointment) { create(:appointment, doctor: doctor, appointment_date: 2.days.ago) }
  let(:recomendation) { 'Take more vitamins and go for a walk outside!' }

  it 'make recomendation' do
    login_user(phone_number, password)

    visit 'appointments'

    find("#wait_for_recomendation_#{appointment.id}").click

    click_link 'Update appointment'

    within("#edit_appointment_#{appointment.id}") do
      fill_in 'Recomendation', with: recomendation
    end

    expect { click_button('Update appointment') }.to change { appointment.reload.recomendation }
      .from(nil).to(recomendation)

    expect(page).to have_content recomendation
    expect(current_path).to eq(appointment_path(appointment))
  end
end
