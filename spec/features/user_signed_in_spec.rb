# frozen_string_literal: true

RSpec.describe 'user signed in', type: :feature do
  subject(:result_page) { page }
  let!(:doctor) { create(:doctor, password: 'password') }

  before { login_user(doctor.phone_number, password) }

  context 'when valid login params' do
    let(:password) { 'password' }

    it { is_expected.to have_content 'You can make appointment right here' }
  end

  context 'when invalid login params' do
    let(:password) { 'passwort' }

    it { is_expected.to have_content 'Invalid Phone number or password.' }
  end
end
