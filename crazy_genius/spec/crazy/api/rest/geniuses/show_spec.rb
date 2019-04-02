# frozen_string_literal: true

# Тесты REST API метода, который выводит информацию об ученом

RSpec.describe Crazy::API::REST::Geniuses::Show do
  describe 'GET /geniuses/:id' do
    include described_class::SpecHelper

    subject(:response) { get "/geniuses/#{id}" }

    let(:id) { genius.id }
    let(:genius) { create(:genius) }

    it 'should invoke Crazy::Actions::Geniuses.show' do
      expect(Crazy::Actions::Geniuses).to receive(:show).and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_ok }

        context 'when the record can\'t be found by provided identifier' do
          let(:id) { create(:uuid) }

          it { is_expected.to be_not_found }
        end
      end

      describe 'body' do
        subject { response.body }

        it { is_expected.to match_json_schema(schema) }
      end
    end
  end
end
