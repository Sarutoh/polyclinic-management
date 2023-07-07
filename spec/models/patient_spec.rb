# frozen_string_literal: true

require 'cancan/matchers'

RSpec.describe Patient, type: :model do
  describe 'abilities' do
    let!(:patient) { create(:patient) }
    let!(:appointment) { create(:appointment, patient: patient, time_slot: create(:time_slot)) }

    subject(:ability) { Ability.new(patient) }

    it 'should be able to create appointment' do
      expect(ability).to  be_able_to(:create, Appointment.new)
    end

    it 'should not be able to update appointment' do
      expect(ability).not_to  be_able_to(:update, appointment)
    end

    it 'should be able to read appointment' do
      expect(ability).to  be_able_to(:read, appointment)
    end

    it 'should not be able to delete appointment' do
      expect(ability).not_to  be_able_to(:delete, appointment)
    end
  end
end
