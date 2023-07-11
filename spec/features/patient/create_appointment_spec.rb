# frozen_string_literal: true

RSpec.describe 'patient create appointment', type: :feature, js: true do
  let(:phone_number) { '+38099887766' }
  let(:password)     { 'password' }
  let!(:doctor1) { create(:doctor) }
  let!(:doctor2) { create(:doctor) }
  let!(:patient) { create(:patient, password: password, phone_number: phone_number) }
  let!(:tomorrow_day) { DateTime.tomorrow.day }

  it 'create appointment' do
    login_user(phone_number, password)

    within('#new_appointment') do
      select doctor2.category.name.to_s, from: 'category_category_id'
      find('#category_category_id')

      select doctor2.full_name.to_s, from: 'appointment_doctor_id'
      find('#appointment_doctor_id')
    end

    page.execute_script %{ $('input#appointment_date').datepicker({dateFormat: 'yy/mm/dd'}) }
    find('input#appointment_date').click
    page.execute_script %{ $("a.ui-state-default:contains('#{tomorrow_day}')").click() }

    find('ul#selectable')
    find('li.list-group-item.rounded', match: :first).click
    find('li.list-group-item.rounded.active')

    expect { click_button('Make appointment') }.to change { doctor2.appointments.reload.count }.by(1)
    expect(page).to have_current_path(appointment_path(Appointment.last))
  end
end
