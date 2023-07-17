# frozen_string_literal: true

RSpec.describe AppointmentsPresenter do
  let!(:appointment) { create(:appointment) }

  context '#participant' do
    subject(:presenter) { described_class.call(participant: params) }

    let(:tag) { "<div>#{opposite_class_name}</div><strong>#{opposite_user.full_name}</strong>" }
    let(:params) { { user: user, appointment: appointment } }

    context 'when doctor' do
      let(:opposite_class_name) { Patient.name }
      let(:opposite_user) { appointment.patient }
      let(:user) { appointment.doctor }

      it { is_expected.to eq(tag) }
    end

    context 'when patient' do
      let(:opposite_class_name) { Doctor.name }
      let(:opposite_user) { appointment.doctor }
      let(:user) { appointment.patient }

      it { is_expected.to eq(tag) }
    end
  end

  context '#wait_to_recomend_id' do
    subject(:presenter) { described_class.call(wait_to_recomend_id: appointment) }

    let(:wait_id) { "#{described_class::WAIT}#{appointment.id}" }
    let(:info_block_id) { "#{described_class::INFO_BLOCK}#{appointment.id}" }

    context 'when allowed to recomendate' do
      before do
        allow(AppointmentsPolicy)
          .to receive_message_chain(:new,
                                    :able_to_recomendate?)
            .with(appointment)
            .with(no_args) { true }
      end

      it { is_expected.to eq(wait_id) }
    end

    context 'when not allowed to recomendate' do
      before do
        allow(AppointmentsPolicy)
          .to receive_message_chain(:new,
                                    :able_to_recomendate?)
            .with(appointment)
            .with(no_args) { false }
      end

      it { is_expected.to eq(info_block_id) }
    end
  end

  context '#user_name' do
    subject(:presenter) { described_class.call(user_name: { user: user, appointment: appointment }) }

    context 'when user doctor' do
      let(:user) { appointment.doctor }

      it { is_expected.to eq(appointment.patient.full_name) }
    end

    context 'when user patient' do
      let(:user) { appointment.patient }

      it { is_expected.to eq(appointment.doctor.full_name) }
    end
  end

  context '#user_role' do
    subject(:presenter) { described_class.call(user_role: user) }

    context 'when user doctor' do
      let(:user) { appointment.doctor }

      it { is_expected.to eq(Patient.name) }
    end

    context 'when user patient' do
      let(:user) { appointment.patient }

      it { is_expected.to eq(Doctor.name) }
    end
  end
end
