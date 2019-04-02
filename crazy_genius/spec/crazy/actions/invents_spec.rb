# frozen_string_literal: true

# Тесты бизнес-логики для изобретений

RSpec.describe Crazy::Actions::Invents do
  describe 'the module' do
    subject { described_class }

    it { is_expected.to respond_to(:create, :destroy, :index, :show) }
  end

  describe '.create' do
    include described_class::Create::SpecHelper

    subject(:result) { described_class.create(params) }

    let(:params) { data }
    let(:data) { attributes_for(:invent).except(:id, :created_at) }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }
    end

    it 'should create new record of invents' do
      expect { subject }.to change { Crazy::Models::Invent.count }.by(1)
    end

    context 'when the record of genius can\'t be found' do
      let(:data) { attributes_for(:invent, traits).except(*columns) }
      let(:traits) { { genius_id: create(:uuid) } }
      let(:columns) { %i[id created_at] }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end

  describe '.destroy' do
    subject { described_class.destroy(params) }
    let(:params) { data }
    let(:data) { { id: id } }
    let!(:id) { invent.id }
    let(:invent) { create(:invent) }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    it 'should destroy record of invent with provided identifier' do
      p Crazy::Models::Invent.count.to_s
      expect { subject }.to change { Crazy::Models::Invent.count }.by(-1)
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end

  describe '.index' do
    include described_class::Index::SpecHelper

    subject(:result) { described_class.index(params) }

    let(:params) { data }
    let(:data) { { genius_id: genius_id } }
    let(:genius_id) { genius.id }
    let(:genius) { create(:genius) }
    let!(:invents) { create_invents(genius_id) }

    it_should_behave_like 'an action parameters receiver',
                          wrong_structure: { page: 'wrong' }

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }

      describe 'size' do
        subject { result.size }

        context 'when `page_size` parameter value is provided' do
          let(:params) { { page_size: page_size, **data } }
          let(:page_size) { 2 }

          it 'should be less than the value or equal it' do
            expect(subject).to be <= page_size
          end
        end

        context 'when `page_size` parameter value is not provided' do
          value = 'Crazy::Actions::Invents::Index::DEFAULT_PAGE_SIZE'
          it "should be less than #{value} or equal it" do
            expect(subject).to be <= described_class::Index::DEFAULT_PAGE_SIZE
          end
        end
      end

      describe 'order' do
        context 'when `order` parameter value is a column name' do
          context 'when `direction` parameter value is absent' do
            let(:params) { { order: :name, **data } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == invents.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { order: :name, direction: :asc, **data } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == invents.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { order: :name, direction: :desc, **data } }

            it 'should be ordered by values of the column descending' do
              expect(result.map { |hash| hash[:name] })
                .to be == invents.map(&:name).sort.reverse
            end
          end
        end

        context 'when `order` parameter value is absent' do
          context 'when `direction` parameter value is absent' do
            let(:params) { data }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == invents.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { direction: :asc, **data } }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == invents.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { direction: :desc, **data } }

            it 'should be ordered by values of `id` column descending' do
              expect(result.map { |hash| hash[:id] })
                .to be == invents.map(&:id).sort.reverse
            end
          end
        end
      end
    end

    context 'when the record of genius can\'t be found' do
      let(:genius_id) { create(:uuid) }
      let!(:invents) { [] }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end

  describe '.show' do
    include described_class::Show::SpecHelper

    subject(:result) { described_class.show(params) }

    let(:params) { data }
    let(:data) { { id: id } }
    let(:id) { invent.id }
    let(:invent) { create(:invent) }

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
    let(:id) { invent.id }
    let(:invent) { create(:invent) }
    let(:update_params) { { name: create(:string), power: create(:integer) } }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    it 'should update fields of record of the genius' do
      subject
      invent.reload
      expect(invent.name).to be == update_params[:name]
      expect(invent.power).to be == update_params[:power]
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end
end
