# frozen_string_literal: true

# Тесты бизнес-логики

RSpec.describe Crazy::Actions::Geniuses do
  describe 'the module' do
    subject { described_class }

    it { is_expected.to respond_to(:create, :destroy, :index, :show, :update) }
  end

  describe '.create' do
    include described_class::Create::SpecHelper

    subject(:result) { described_class.create(params) }

    let(:params) { data }
    let(:data) { attributes_for(:genius).except(:id, :created) }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }
    end

    it 'should create new record of genius' do
      expect { subject }.to change { Crazy::Models::Geniuses.count }.by(1)
    end
  end

  describe '.destroy' do
    subject { described_class.destroy(params) }

    let(:params) { data }
    let(:data) { { id: id } }
    let!(:id) { genius.id }
    let(:genius) { create(:genius) }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    it 'should destroy the record of genius with provided identifier' do
      expect { subject }.to change { Crazy::Models::Geniuses.count }.by(-1)
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end

    context 'when there is a record of a invent of the genius' do
      let!(:invent) { create(:invent, traits) }
      let(:traits) { { genius_id: id } }

      it 'should raise Sequel::ForeignKeyConstraintViolation' do
        expect { subject }
          .to raise_error(Sequel::ForeignKeyConstraintViolation)
      end
    end
  end

  describe '.index' do
    include described_class::Index::SpecHelper

    subject(:result) { described_class.index(params) }

    let(:params) { data }
    let(:data) { {} }
    let!(:genius) { create_genius }

    it_should_behave_like 'an action parameters receiver',
                          wrong_structure: { page: 'wrong' }

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }

      describe 'size' do
        subject { result.size }

        context 'when `page_size` parameter value is provided' do
          let(:params) { { page_size: page_size } }
          let(:page_size) { 2 }

          it 'should be less than the value or equal it' do
            expect(subject).to be <= page_size
          end
        end

        context 'when `page_size` parameter value is not provided' do
          value = 'Crazy::Actions::Geniuses::Index::DEFAULT_PAGE_SIZE'
          it "should be less than #{value} or equal it" do
            expect(subject).to be <= described_class::Index::DEFAULT_PAGE_SIZE
          end
        end
      end

      describe 'order' do
        context 'when `order` parameter value is a column name' do
          context 'when `direction` parameter value is absent' do
            let(:params) { { order: :name } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == genius.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { order: :name, direction: :asc } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == genius.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { order: :name, direction: :desc } }

            it 'should be ordered by values of the column descending' do
              expect(result.map { |hash| hash[:name] })
                .to be == genius.map(&:name).sort.reverse
            end
          end
        end

        context 'when `order` parameter value is absent' do
          context 'when `direction` parameter value is absent' do
            let(:params) { {} }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == genius.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { direction: :asc } }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == genius.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { direction: :desc } }

            it 'should be ordered by values of `id` column descending' do
              expect(result.map { |hash| hash[:id] })
                .to be == genius.map(&:id).sort.reverse
            end
          end
        end
      end
    end
  end

  describe '.show' do
    include described_class::Show::SpecHelper

    subject(:result) { described_class.show(params) }

    let(:params) { data }
    let(:data) { { id: id } }
    let(:id) { genius.id }
    let(:genius) { create(:genius) }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end

  describe '.update' do
    subject { described_class.update(params) }

    let(:params) { data }
    let(:data) { { id: id, **update_params } }
    let(:id) { genius.id }
    let(:genius) { create(:genius) }
    let(:update_params) { attributes_for(:genius).except(*columns) }
    let(:columns) { %i[id created] }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    it 'should update fields of record of the genius' do
      subject
      genius.reload
      expect(genius.name).to be == update_params[:name]
      expect(genius.crazy).to be == update_params[:crazy]
      expect(genius.try_kill).to be == update_params[:try_kill]
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end
end
