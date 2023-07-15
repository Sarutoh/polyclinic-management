# frozen_string_literal: true

RSpec.describe AppointmentsController, type: :controller do
  describe 'controller test case' do
    let(:doctor) { create(:doctor) }
    let(:patient) { create(:patient) }

    before { sign_in doctor }

    context '#create' do
      subject(:make_request) { post :create, params: { appointment: appointment_params.merge(time_slot) } }
      let(:notice_message) { I18n.t('success.create', record: Appointment.name) }

      before { make_request }

      let(:appointment_params) do
        {
          doctor_id: doctor.id,
          patient_id: patient.id
        }
      end

      context 'when valid params' do
        let(:time_slot) { { time_slot: "#{Date.tomorrow.strftime('%y/%m/%d')} 12:00" } }

        it 'redirects to appointment show' do
          expect(response).to redirect_to(appointment_path(Appointment.last))
          expect(request.flash[:notice]).to eq(notice_message)
        end
      end

      context 'when invalid params' do
        context 'when timeslot nil' do
          let(:alert_message) { { slot: [I18n.t('appointment.empty_slot')] } }
          let(:time_slot) { { time_slot: '' } }

          it 'redirects to appointment show with alert' do
            expect(response).to redirect_to(root_path)
            expect(request.flash[:alert].messages).to eq(alert_message)
          end
        end

        context 'when timeslot invalid' do
          let(:alert_message) { { date: [I18n.t('appointment.invalid_date')] } }

          let(:time_slot) { { time_slot: '11/07/23 12:00' } }

          it 'redirects to appointment show with alert' do
            expect(response).to redirect_to(root_path)
            expect(request.flash[:alert].messages).to eq(alert_message)
          end
        end
      end
    end

    context '#update' do
      subject(:make_request) do
        put :update, params: { id: appointment.id, appointment: {
          description: 'Stomach pain',
          recomendation: recomendation
        } }
      end
      let(:description) { 'Back pain' }
      let(:appointment) do
        create(:appointment, description: description, doctor: doctor, time_slot: create(:time_slot, :passed))
      end

      context 'when valid params' do
        let(:notice_message) { I18n.t('success.update', record: Appointment.name) }
        let(:recomendation) { 'Use a pill' }

        it 'updates appointment' do
          expect { make_request }.to change { appointment.reload.description }
            .from(description).to('Stomach pain')
            .and change {
                   appointment.recomendation
                 }.from('').to(recomendation)
            .and change {
                   appointment.closed
                 }.from(false).to(true)

          expect(request.flash[:notice]).to eq(notice_message)
        end
      end

      context 'when invalid params' do
        let(:recomendation) { 'Use pill' }
        let(:alert_message) do
          { recomendation: [I18n.t('errors.messages.too_short.other', count: Appointment::RECOMENDATION_LENGTH[:min])] }
        end

        it 'does not update appointment' do
          expect { make_request }.not_to(change { appointment.reload })

          expect(request.flash[:alert].messages).to eq(alert_message)
        end
      end
    end
  end
end
