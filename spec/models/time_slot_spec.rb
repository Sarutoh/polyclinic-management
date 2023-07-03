# frozen_string_literal: true

RSpec.describe TimeSlot, type: :model do
  subject(:time_slot) { create(:time_slot, appointment_date: DateTime.new(2023, 2, 3, 12, 0)) }

  describe '#starts_at' do
    let(:expected_result) { '12:00' }

    it { expect(subject.starts_at).to eq(expected_result) }
  end
end
