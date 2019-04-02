# frozen_string_literal: true

# Тесты REST API метода, который выводит записи об изобретениях

RSpec.describe Crazy::API::REST::Invents::Index do
  describe 'GET /geniuses/:id/invents' do
    include described_class::SpecHelper

    subject(:response) { get url, params }

    let(:url) { "/geniuses/#{id}/invents" }
    let(:id) { genius.id }
    let(:genius) { create(:genius) }
    let(:params) { { order: :name } }
    let!(:invents) { create_list(:invent, 3, traits) }
    let(:traits) { { genius_id: id } }

    it 'should invoke Crazy::Actions::Invents.index' do
      expect(Crazy::Actions::Invents)
        .to receive(:index)
        .and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_ok }

        context 'when params are wrong' do
          let(:params) { { wrong: :structure } }

          it { is_expected.to be_unprocessable }
        end
      end

      describe 'body' do
        subject { response.body }

        it { is_expected.to match_json_schema(schema) }
      end
    end
  end
end
