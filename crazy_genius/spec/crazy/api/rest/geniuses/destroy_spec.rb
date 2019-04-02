# frozen_string_literal: true

# Тесты REST API метода, который удаляет запись об ученом

RSpec.describe Crazy::API::REST::Geniuses::Destroy do
  describe 'DELETE /geniuses/:id' do
    subject(:response) { delete "/geniuses/#{id}" }

    let(:id) { genius.id }
    let(:genius) { create(:genius) }

    it 'should invoke Crazy::Actions::Geniuses.destroy' do
      expect(Crazy::Actions::Geniuses)
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

        context 'when there is a linked record of a doomsday machine' do
          let!(:invent) { create(:invent, traits) }
          let(:traits) { { genius_id: id } }

          it { is_expected.to be_unprocessable }
        end
      end
    end
  end
end
