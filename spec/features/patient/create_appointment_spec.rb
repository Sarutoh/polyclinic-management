# frozen_string_literal: true

RSpec.describe 'patient create appointment', type: :feature, js: true do
  let(:phone_number) { '+38099887766' }
  let(:password)     { 'password' }
  let!(:doctor) { create(:doctor) }
  let!(:patient) { create(:patient, password: password, phone_number: phone_number) }

  before do
    visit '/'

    within('#new_user') do
      fill_in 'Phone number', with: phone_number
      fill_in 'Password', with: password
    end

    click_button 'Log in'
  end

  it 'create appointment' do
    within('#new_appointment') do
      fill_in 'Appointment date', with: 2.days.from_now
      select doctor.category.name.to_s, from: 'category_category_id'
      select doctor.full_name.to_s, from: 'appointment_doctor_id'
    end

    click_button('Make appointment')

    sleep 0.5

    expect(current_path).to eq(appointment_path(Appointment.last))
  end
end
