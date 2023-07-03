# frozen_string_literal: true

RSpec.describe AppointmentsController, type: :controller do
  describe 'controller test case' do
    let(:doctor) { create(:doctor) }
    let(:patient) { create(:patient) }

    context '#create' do
      before { sign_in doctor }

      it 'redirects to appointment show' do
        post :create, params: {
          appointment: {
            doctor_id: doctor.id,
            patient_id: patient.id,
            time_slot: '05/07/2023 12:00'
          }
        }

        expect(response).to redirect_to(appointment_path(Appointment.last))
      end
    end
  end
end
