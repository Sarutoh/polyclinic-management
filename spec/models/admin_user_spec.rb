# frozen_string_literal: true

require 'cancan/matchers'

RSpec.describe AdminUser, type: :model do
  describe 'abilities' do
    let!(:admin) { create(:admin_user) }
    let!(:appointment) { create(:appointment, time_slot: create(:time_slot)) }

    subject(:ability) { Ability.new(admin) }

    it 'should be able to create users' do
      expect(ability).to  be_able_to(:create, Doctor.new)
    end

    it 'should be able to create categories' do
      expect(ability).to  be_able_to(:create, Category.new)
    end

    it 'should be able to create appointments' do
      expect(ability).to  be_able_to(:create, Appointment.new)
    end

    it 'should be able to update appointment' do
      expect(ability).to  be_able_to(:update, appointment)
    end

    it 'should be able to read appointment' do
      expect(ability).to  be_able_to(:read, appointment)
    end

    it 'should be able to delete appointment' do
      expect(ability).to  be_able_to(:delete, appointment)
    end
  end
end
