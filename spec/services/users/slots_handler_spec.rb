# frozen_string_literal: true

RSpec.describe Users::SlotsHandler do
  subject(:query) { described_class.call(patient, doctor, date) }

  describe 'get expected time slots' do
    let(:patient) { create(:patient) }
    let(:doctor) { create(:doctor) }
    let(:hour) { '12:00' }
    let(:date) { "#{Date.tomorrow.strftime('%y/%m/%d')} #{hour}" }

    context 'when users do not have booked appointments' do
      it { is_expected.to eq(Users::SlotsHandler::POSSIBLE_SLOTS) }
    end

    context 'when users have booked appointments' do
      before do
        create(:appointment,
               patient: patient,
               time_slot: create(:time_slot, appointment_date: DateTime.tomorrow.midday.change(hour: 12)))
      end

      it { is_expected.to eq(Users::SlotsHandler::POSSIBLE_SLOTS.excluding(hour)) }
    end
  end
end
