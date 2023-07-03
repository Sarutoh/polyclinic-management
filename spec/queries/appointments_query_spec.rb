# frozen_string_literal: true

RSpec.describe AppointmentsQuery do
  subject(:query) { described_class.new(user) }

  describe 'get expected results' do
    let(:user) { create(:patient) }
    let!(:appointment1) do
      create(:appointment, patient: user, time_slot: create(:time_slot, appointment_date: 1.hour.ago))
    end
    let!(:appointment2) do
      create(:appointment, patient: user, time_slot: create(:time_slot, appointment_date: 2.days.ago))
    end
    let!(:appointment3) do
      create(:appointment, patient: user, time_slot: create(:time_slot, appointment_date: 2.days.from_now))
    end
    let!(:appointment4) do
      create(:appointment, patient: user, time_slot: create(:time_slot, appointment_date: 1.hour.from_now))
    end
    let!(:appointment5) do
      create(:appointment, time_slot: create(:time_slot, appointment_date: 1.day.ago))
    end

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
