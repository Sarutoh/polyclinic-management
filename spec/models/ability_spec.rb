# frozen_string_literal: true

require 'cancan/matchers'

RSpec.describe Doctor, type: :model do
  subject(:ability) { Ability.new(user) }

  let!(:appointment) { create(:appointment, time_slot: create(:time_slot)) }

  context 'when admin' do
    let(:user) { create(:admin_user) }

    it { is_expected.to  be_able_to(:create, Doctor.new) }

    it { is_expected.to  be_able_to(:create, Patient.new) }

    it { is_expected.to  be_able_to(:create, Category.new) }

    it { is_expected.to  be_able_to(:delete, appointment) }

    it { is_expected.to  be_able_to(:update, appointment) }

    include_examples 'read_and_create'
  end

  context 'when doctor' do
    let(:user) { appointment.doctor }

    it { is_expected.to be_able_to(:update, appointment) }

    it { is_expected.not_to be_able_to(:delete, appointment) }

    include_examples 'read_and_create'
  end

  context 'when patient' do
    let(:user) { appointment.patient }

    it { is_expected.not_to  be_able_to(:update, appointment) }

    it { is_expected.not_to  be_able_to(:delete, appointment) }

    include_examples 'read_and_create'
  end
end
