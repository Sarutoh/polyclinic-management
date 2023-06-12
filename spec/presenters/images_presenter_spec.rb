# frozen_string_literal: true

RSpec.describe ImagesPresenter do
  subject(:presenter) { described_class.call(avatar: { user: user, type: type }) }

  context 'when return expected tag' do
    let(:user) { create(:patient) }
    let(:tag_class) { described_class::TAG_CLASS }
    let(:avatar_url) { described_class::DEFAULT_AVATAR_URL }
    let(:tag) do
      "<img src=\"#{avatar_url}\" class=\"#{tag_class}\" width=\"#{size}\" height=\"#{size}\">"
    end

    context 'when avatar not attached' do
      context 'when edit profile page' do
        let(:type) { :edit_avatar }
        let(:size) { described_class::SIZES[type] }

        it { is_expected.to eq(tag) }
      end

      context 'when other pages' do
        let(:type) { :avatar }
        let(:size) { described_class::SIZES[type] }

        it { is_expected.to eq(tag) }
      end
    end

    context 'when avatar attached' do
      let(:avatar_url) { user.avatar.url }
      let!(:image) { "#{SecureRandom.uuid}.png" }

      before do
        allow(user).to receive_message_chain('avatar.attached?') { true }
        allow(user).to receive_message_chain('avatar.url') { image }
      end

      context 'when edit profile page' do
        let(:type) { :edit_avatar }
        let(:size) { described_class::SIZES[type] }

        it { is_expected.to eq(tag) }
      end

      context 'when other pages' do
        let(:type) { :avatar }
        let(:size) { described_class::SIZES[type] }

        it { is_expected.to eq(tag) }
      end
    end
  end
end
