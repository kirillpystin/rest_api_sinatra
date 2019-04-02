# frozen_string_literal: true

# Тесты REST API метода, который обновляет информацию об ученых
RSpec.describe Crazy::API::REST::Geniuses::Index do
  describe 'GET /geniuses' do
    include described_class::SpecHelper

    subject(:response) { get '/geniuses', params }

    let(:params) { { order: :name } }
    let!(:genius) { create_list(:genius, 3) }

    it 'should invoke Crazy::Actions::Invents.index' do
      expect(Crazy::Actions::Geniuses).to receive(:index).and_call_original
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
