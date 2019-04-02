# frozen_string_literal: true

# Тесты REST API метода, который создает запись об изобретении

RSpec.describe Crazy::API::REST::Invents::Create do
  describe 'POST /geniuses/:id/invents' do
    include described_class::SpecHelper

    subject(:response) { post url, request_body }
    let(:url) { "/geniuses/#{id}/invents" }
    let(:id) { genius.id }
    let(:genius) { create(:genius) }
    let(:request_body) { Oj.dump(params) }
    let(:params) { { name: create(:string), power: create(:integer) } }

    it 'should invoke Crazy::Actions::Invents.create' do
      expect(Crazy::Actions::Invents)
        .to receive(:create)
        .and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_created }

        context 'when the record of mad scientist can\'t be found' do
          let(:id) { create(:uuid) }

          it { is_expected.to be_not_found }
        end

        context 'when request body is not a JSON-string' do
          let(:request_body) { 'not a JSON-string' }

          it { is_expected.to be_unprocessable }
        end

        context 'when params are wrong' do
          let(:params) { 'wrong' }

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
