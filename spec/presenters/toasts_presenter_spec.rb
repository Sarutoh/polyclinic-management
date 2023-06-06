# frozen_string_literal: true

RSpec.describe ToastsPresenter do
  context 'when return expected flash class' do
    subject(:presenter) { described_class.call(flash_class: type) }

    let(:expected_result) { "toast-header #{described_class::FLASH_CLASSES[type.to_sym]}" }

    context 'when notice' do
      let(:type) { 'notice' }

      it { expect(presenter).to eq(expected_result) }
    end
    context 'when success' do
      let(:type) { 'success' }

      it { expect(presenter).to eq(expected_result) }
    end
    context 'when alert' do
      let(:type) { 'alert' }

      it { expect(presenter).to eq(expected_result) }
    end
  end

  context 'when return expected result' do
    subject(:presenter) { described_class.call(include_flash?: type) }

    context 'when included' do
      let(:type) { 'alert' }

      it { expect(presenter).to be_truthy }
    end

    context 'when not included' do
      let(:type) { 'error' }

      it { expect(presenter).to be_falsey }
    end
  end

  context 'when return expected flash message' do
    subject(:presenter) { described_class.call(handle_message: message) }

    context 'when message string' do
      let(:message) { 'Alert message' }

      it { expect(presenter).to eq(message) }
    end

    context 'when message model error' do
      let(:text) { 'has too many appointments!' }
      let(:message) { { 'doctor' => [text] } }

      it { expect(presenter).to eq('Doctor has too many appointments!') }
    end
  end
end
