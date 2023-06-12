# frozen_string_literal: true

RSpec.describe 'doctor create appointment', type: :feature do
  let(:phone_number) { '+38099887766' }
  let(:password)     { 'password' }
  let!(:doctor) { create(:doctor, password: password, phone_number: phone_number) }
  let!(:patient) { create(:patient) }

  before do
    login_user(phone_number, password)

    within('#new_appointment') do
      fill_in 'Appointment date', with: Time.zone.now
      select patient.full_name.to_s, from: 'appointment_patient_id'
    end
  end

  context 'when create appointment' do
    it 'create appointment' do
      expect { click_button('Make appointment') }.to change { Appointment.count }.by(1)
      expect(current_path).to eq(appointment_path(Appointment.last))
    end
  end

  context 'when not create appointment' do
    before { create_list(:appointment, 10, doctor: doctor) }

    it 'show error' do
      expect { click_button('Make appointment') }.not_to(change { Appointment.count })
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Doctor has too many appointments!')
    end
  end
end
