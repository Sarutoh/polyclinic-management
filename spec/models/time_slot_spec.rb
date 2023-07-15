# frozen_string_literal: true

RSpec.describe TimeSlot, type: :model do
  subject(:time_slot) { create(:time_slot, appointment_date: DateTime.new(2023, 2, 3, 12, 0)).starts_at }

  describe '#starts_at' do
    let(:expected_result) { '12:00' }

    it { is_expected.to eq(expected_result) }
  end
end
