# frozen_string_literal: true

# Тесты REST API метода, который создает запись об ученом

RSpec.describe Crazy::API::REST::Geniuses::Create do
  describe 'POST /geniuses' do
    include described_class::SpecHelper

    subject(:response) { post '/geniuses', request_body }

    let(:request_body) { Oj.dump(params) }
    let(:params) { attributes_for(:genius).except(:id, :created) }

    it 'should invoke Crazy::Actions::Geniuses.create' do
      expect(Crazy::Actions::Geniuses).to receive(:create).and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_created }

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
