# frozen_string_literal: true

RSpec.describe AppointmentsQuery do
  subject(:query) { described_class.new(user) }

  describe 'get expected results' do
    let(:user) { create(:patient) }
    let!(:appointment1) { create(:appointment, patient: user, appointment_date: 10.minutes.ago) }
    let!(:appointment2) { create(:appointment, patient: user, appointment_date: 2.days.ago) }
    let!(:appointment3) { create(:appointment, patient: user, appointment_date: 2.days.from_now) }
    let!(:appointment4) { create(:appointment, patient: user, appointment_date: 1.minute.from_now) }
    let!(:appointment5) { create(:appointment, appointment_date: 1.day.ago) }

    context 'when call planned_appointments' do
      it { expect(query.planned_appointments).to contain_exactly(appointment4, appointment3) }
    end

    context 'when call finished_appointments' do
      it { expect(query.finished_appointments).to contain_exactly(appointment2, appointment1) }
    end

    context 'when call last_appointment' do
      it { expect(query.last_appointment).to eq(appointment1) }
    end

    context 'when call nearest_appointment' do
      it { expect(query.nearest_appointment).to eq(appointment4) }
    end
  end
end
