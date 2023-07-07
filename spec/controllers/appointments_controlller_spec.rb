# frozen_string_literal: true

RSpec.describe AppointmentsController, type: :controller do
  describe 'controller test case' do
    let(:doctor) { create(:doctor) }
    let(:patient) { create(:patient) }

    context '#create' do
      let(:notice_message) { 'Appointment was successfully created.' }

      before { sign_in doctor }

      context 'when valid params' do
        it 'redirects to appointment show' do
          post :create, params: {
            appointment: {
              doctor_id: doctor.id,
              patient_id: patient.id,
              time_slot: '05/07/2023 12:00'
            }
          }

          expect(response).to redirect_to(appointment_path(Appointment.last))
          expect(request.flash[:notice]).to eq(notice_message)
        end
      end

      context 'when invalid params' do
        let(:alert_message) do
          {
            slot: ['cannot be nil. Please choose one.']
          }
        end

        it 'redirects to appointment show' do
          post :create, params: {
            appointment: {
              doctor_id: doctor.id,
              patient_id: patient.id,
              time_slot: ''
            }
          }

          expect(response).to redirect_to(root_path)
          expect(request.flash[:alert].messages).to eq(alert_message)
        end
      end
    end

    context '#update' do
      subject(:update_request) do
        put :update, params: { id: appointment.id, appointment: {
          description: 'Stomach pain',
          recomendation: recomendation
        } }
      end
      let(:appointment) do
        create(:appointment, description: 'Back pain', doctor: doctor, time_slot: create(:time_slot, :passed))
      end

      before { sign_in doctor }

      context 'when valid params' do
        let(:notice_message) { 'Appointment was successfully updated.' }
        let(:recomendation) { 'Use a pill' }

        it 'updates appointment' do
          expect { update_request }.to change { appointment.reload.description }
            .from('Back pain').to('Stomach pain')
            .and change {
                   appointment.recomendation
                 }.from('').to('Use a pill')
            .and change {
                   appointment.closed
                 }.from(false).to(true)

          expect(request.flash[:notice]).to eq(notice_message)
        end
      end

      context 'when invalid params' do
        let(:recomendation) { 'Use pill' }
        let(:alert_message) do
          {
            recomendation: ['is too short (minimum is 10 characters)']
          }
        end

        it 'updates appointment' do
          expect { update_request }.not_to(change { appointment.reload })

          expect(request.flash[:alert].messages).to eq(alert_message)
        end
      end
    end
  end
end
