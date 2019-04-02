# frozen_string_literal: true

# Тесты REST API метода, который обновляет запись об изобретении

RSpec.describe Crazy::API::REST::Invents::Update do
  describe 'PUT /invents/:id' do
    subject(:response) { put "/invents/#{id}", request_body }

    let(:id) { invent.id }
    let(:invent) { create(:invent) }
    let(:request_body) { Oj.dump(params) }
    let(:params) { { name: create(:string), power: create(:integer) } }

    it 'should invoke Crazy::Actions::Invents.update' do
      expect(Crazy::Actions::Invents)
        .to receive(:update)
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
