# frozen_string_literal: true

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
end
