# frozen_string_literal: true

# Тесты REST API метода, который удаляет запись об изобретении

RSpec.describe Crazy::API::REST::Invents::Destroy do
  describe 'DELETE /invents/:id' do
    subject(:response) { delete "/invents/#{id}" }

    let(:id) { invent.id }
    let(:invent) { create(:invent) }

    it 'should invoke Crazy::Actions::DoomsdayMachines.destroy' do
      expect(Crazy::Actions::Invents)
        .to receive(:destroy)
        .and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_no_content }

        context 'when the record can\'t be found by provided identifier' do
          let(:id) { create(:uuid) }

          it { is_expected.to be_not_found }
        end
      end
    end
  end
end
