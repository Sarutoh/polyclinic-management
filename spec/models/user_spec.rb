# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'validations' do
    subject(:user) { described_class.new(params).valid? }

    let(:params) { { password: 'password', type: Patient.name } }
    context 'when phone_number' do
      before { params.merge!(phone_number) }

      context 'when is valid' do
        let(:phone_number) { { phone_number: '930000000' } }

        it { is_expected.to be_truthy }
      end

      context 'when is invalid' do
        context 'when too short' do
          let(:phone_number) { { phone_number: '09300000' } }

          it { is_expected.to be_falsey }
        end

        context 'when too long' do
          let(:phone_number) { { phone_number: '930000000000000' } }

          it { is_expected.to be_falsey }
        end

        context 'when contain chars' do
          let(:phone_number) { { phone_number: '93000000a' } }

          it { is_expected.to be_falsey }
        end

        context 'when contain special symbols' do
          let(:phone_number) { { phone_number: '93000000@' } }

          it { is_expected.to be_falsey }
        end

        context 'when not unique' do
          before { create(:patient, phone_number: '930000001') }

          let(:phone_number) { { phone_number: '930000001' } }

          it { is_expected.to be_falsey }
        end

        context 'when not present' do
          let(:phone_number) { { phone_number: '' } }

          it { is_expected.to be_falsey }
        end
      end
    end
  end
end
