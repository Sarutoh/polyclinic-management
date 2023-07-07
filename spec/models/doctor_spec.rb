# frozen_string_literal: true

require 'cancan/matchers'

RSpec.describe Doctor, type: :model do
  describe 'validations' do
    subject(:doctor) { described_class.new(params).valid? }

    let(:category) { create(:category) }
    let(:params) { { password: 'password', category: category } }

    before { params.merge!(phone_number) }

    context 'when is valid' do
      let(:phone_number) { { phone_number: '+380930000000' } }

      it { is_expected.to be_truthy }
    end

    context 'when is invalid' do
      context 'when too short' do
        let(:phone_number) { { phone_number: '+38093' } }

        it { is_expected.to be_falsey }
      end

      context 'when too long' do
        let(:phone_number) { { phone_number: '+380930000000000000' } }

        it { is_expected.to be_falsey }
      end

      context 'when contain chars' do
        let(:phone_number) { { phone_number: '+38093000000a' } }

        it { is_expected.to be_falsey }
      end

      context 'when contain special symbols' do
        let(:phone_number) { { phone_number: '+38093000000@' } }

        it { is_expected.to be_falsey }
      end
    end
  end

  describe 'abilities' do
    let!(:doctor) { create(:doctor) }
    let!(:appointment) { create(:appointment, doctor: doctor, time_slot: create(:time_slot)) }

    subject(:ability) { Ability.new(doctor) }

    it 'should be able to create appointment' do
      expect(ability).to  be_able_to(:create, Appointment.new)
    end

    it 'should be able to update appointment' do
      expect(ability).to  be_able_to(:update, appointment)
    end

    it 'should be able to read appointment' do
      expect(ability).to  be_able_to(:read, appointment)
    end

    it 'should not be able to delete appointment' do
      expect(ability).not_to  be_able_to(:delete, appointment)
    end
  end
end
