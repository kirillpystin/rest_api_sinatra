# frozen_string_literal: true

# Тесты REST API метода, который выводит запись об изобретении
RSpec.describe Crazy::API::REST::Invents::Show do
  describe 'GET /invents/:id' do
    include described_class::SpecHelper

    subject(:response) { get "/invents/#{id}" }

    let(:id) { invent.id }
    let(:invent) { create(:invent) }

    it 'should invoke Crazy::Actions::Invents.show' do
      expect(Crazy::Actions::Invents)
        .to receive(:show)
        .and_call_original
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
