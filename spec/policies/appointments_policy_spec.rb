# frozen_string_literal: true

RSpec.describe AppointmentsPolicy do
  subject(:policy) { described_class.new(appointment).able_to_recomendate? }

  context '#able_to_recomendate?' do
    context 'when able' do
      let(:appointment) { create(:appointment, appointment_date: 2.days.ago) }

      it { is_expected.to be_truthy }
    end

    context 'when not able' do
      context 'when closed' do
        let(:appointment) { create(:appointment, appointment_date: 2.days.ago, closed: true) }

        it { is_expected.to be_falsey }
      end

      context 'when appointment date upcoming' do
        let(:appointment) { create(:appointment, appointment_date: 2.days.from_now) }

        it { is_expected.to be_falsey }
      end
    end
  end
end
