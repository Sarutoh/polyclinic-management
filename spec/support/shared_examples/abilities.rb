# frozen_string_literal: true

RSpec.shared_examples 'read_and_create' do
  it { is_expected.to  be_able_to(:create, Appointment.new, TimeSlot.new) }

  it { is_expected.to  be_able_to(:read, appointment, appointment.time_slot) }
end
