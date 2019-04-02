# frozen_string_literal: true

# Тесты REST API метода, который обновляет информацию об ученом

RSpec.describe Crazy::API::REST::Geniuses::Update do
  describe 'PUT /geniuses/:id' do
    subject(:response) { put "/geniuses/#{id}", request_body }

    let(:id) { genius.id }
    let(:genius) { create(:genius) }
    let(:request_body) { Oj.dump(params) }
    let(:params) { attributes_for(:genius).except(:id, :created) }

    it 'should invoke Crazy::Actions::Geniuses.update' do
      expect(Crazy::Actions::Geniuses).to receive(:update).and_call_original
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
