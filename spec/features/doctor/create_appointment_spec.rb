# frozen_string_literal: true

RSpec.describe 'doctor create appointment', type: :feature, js: true do
  let(:phone_number) { '+38099887766' }
  let(:password)     { 'password' }
  let!(:doctor) { create(:doctor, password: password, phone_number: phone_number) }
  let!(:patient) { create(:patient) }
  let!(:tomorrow_day) { DateTime.tomorrow.day }

  before do
    login_user(phone_number, password)

    within('#new_appointment') do
      select patient.full_name.to_s, from: 'appointment_patient_id'
      li = find('li.list-group-item', match: :first)
      li.click
    end

    page.execute_script %{ $('input#appointment_date').datepicker({dateFormat: 'yy/mm/dd'}) }
    find('input#appointment_date').click
    page.execute_script %{ $("a.ui-state-default:contains('#{tomorrow_day}')").click() }

    page.execute_script %{ $("#appointment_time_slot").val($('.active').text() + $('#appointment_date').val()) }

    find('ul#selectable')
    find('li.list-group-item.rounded', match: :first).click
    find('li.list-group-item.rounded.active')
  end

  context 'when create appointment' do
    it 'create appointment' do
      expect { click_button('Make appointment') }.to change { doctor.appointments.reload.count }.by(1)
      expect(page).to have_current_path(appointment_path(Appointment.last))
    end
  end

  context 'when not create appointment' do
    before { create_list(:appointment, 10, doctor: doctor, time_slot: create(:time_slot)) }

    it 'show error' do
      expect { click_button('Make appointment') }.not_to(change { Appointment.count })
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Doctor has too many appointments!')
    end
  end
end
