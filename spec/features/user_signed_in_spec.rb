# frozen_string_literal: true

RSpec.describe 'user signed in', type: :feature do
  let!(:doctor) { create(:doctor, password: 'password') }

  before { login_user(doctor.phone_number, password) }

  context 'when valid login params' do
    let(:password) { 'password' }

    it 'signs me in' do
      expect(page).to have_content 'You can make appointment right here'
    end
  end

  context 'when invalid login params' do
    let(:password) { 'passwort' }

    it 'show error' do
      expect(page).to have_content 'Invalid Phone number or password.'
    end
  end
end
