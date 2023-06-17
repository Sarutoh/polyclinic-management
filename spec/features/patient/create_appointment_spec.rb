# frozen_string_literal: true

RSpec.describe 'patient create appointment', type: :feature, js: true do
  let(:phone_number) { '+38099887766' }
  let(:password)     { 'password' }
  let!(:doctor1) { create(:doctor) }
  let!(:doctor2) { create(:doctor) }
  let!(:patient) { create(:patient, password: password, phone_number: phone_number) }

  it 'create appointment' do
    login_user(phone_number, password)

    within('#new_appointment') do
      select doctor2.category.name.to_s, from: 'category_category_id'
      find('#category_category_id')

      select doctor2.full_name.to_s, from: 'appointment_doctor_id'
      find('#appointment_doctor_id')
    end

    li = find('li.list-group-item', match: :first)

    appointment_date = li.value

    li.click

    expect { click_button('Make appointment') }.to change { Appointment.count }.by(1)
    expect(page).to have_content(appointment_date)
  end
end
