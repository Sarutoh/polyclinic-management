# frozen_string_literal: true

RSpec.describe AppointmentsController, type: :controller do
  describe 'controller test case ' do
    let(:doctor) { create(:doctor) }
    let(:patient) { create(:patient) }

    context '#create' do
      before { sign_in doctor }

      it 'redirects to appointment show' do
        post :create, params: {
          appointment: {
            doctor_id: doctor.id,
            patient_id: patient.id,
            appointment_date: 2.days.from_now
          }
        }

        expect(response).to redirect_to(appointment_path(Appointment.last))
      end
    end
  end
end
