# frozen_string_literal: true

require_relative '../../spec_helper'

# Тесты для модели Genius
RSpec.describe Crazy::Models::Geniuses do
  describe 'the model' do
    subject { described_class }

    it { is_expected.to respond_to(:new, :create) }
  end

  describe '.new' do
    subject(:result) { described_class.new(params) }

    describe 'result' do
      subject { result }
      let(:params) { attributes_for(:genius).except(:id) }
      it { is_expected.to be_an_instance_of(described_class) }
    end
  end

  describe '.create' do
    subject(:result) { described_class.create(params) }
    describe 'result' do
      subject { result }
      let(:params) { attributes_for(:genius) }
      it { is_expected.to be_a(described_class) }
    end

    context 'when value of `id` property is nil' do
      let(:params) { attributes_for(:genius, id: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end

    context 'when value of `id` property is of String' do
      context 'when the value is not of UUID format' do
        let(:params) { attributes_for(:genius, id: value) }
        let(:value) { 'not of UUID format' }

        it 'should raise Sequel::DatabaseError' do
          expect { subject }.to raise_error(Sequel::DatabaseError)
        end
      end
    end

    context 'when `params` doesn\'t contain `name` property' do
      let(:params) { attributes_for(:genius).except(:name) }

      it 'should raise Sequel::NotNullConstraintViolation' do
        expect { subject }.to raise_error(Sequel::NotNullConstraintViolation)
      end
    end

    context 'when value of `name` property is nil' do
      let(:params) { attributes_for(:genius, name: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end
  end

  describe 'instance of the model' do
    subject(:instance) { create(:genius) }

    messages = %i[id name crazy try_kill created update destroy]
    it { is_expected.to respond_to(*messages) }
  end

  describe '#id' do
    subject(:result) { instance.id }

    describe 'result' do
      subject { result }

      let(:instance) { create(:genius) }

      it { is_expected.to be_a(String) }
      it { is_expected.to match_uuid_format }
    end
  end

  describe '#name' do
    subject(:result) { instance.name }

    let(:instance) { create(:genius) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(String) }
    end
  end

  describe '#crazy' do
    subject(:result) { instance.crazy }

    let(:instance) { create(:genius) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_an(Integer) }
      it { is_expected.to be >= 0 }
    end
  end

  describe '#try_kill' do
    subject(:result) { instance.try_kill }

    let(:instance) { create(:genius) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_an(Integer) }
      it { is_expected.to be >= 0 }
    end
  end

  describe '#created' do
    subject(:result) { instance.created }

    let(:instance) { create(:genius) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(Time) }
    end
  end

  describe '#update' do
    subject(:result) { instance.update(params) }

    let(:instance) { create(:genius) }

    context 'when `name` property is present in parameters' do
      let(:params) { { name: value } }

      context 'when the value is of String' do
        let(:value) { create(:string) }

        it 'should set `name` attribute of the instance to the value' do
          expect { subject }.to change { instance.name }.to(value)
        end
      end

      context 'when the value is nil' do
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end

    context 'when `created` property is present in parameters' do
      let(:params) { { created: value } }

      context 'when the value is of String' do
        context 'when the value is a time\'s representation' do
          before { subject }

          let(:value) { created.to_s }
          let(:created) { Time.now - 1 }

          it 'should set `created_at` attribute to the date' do
            expect(instance.created).to be_within(1).of(created)
          end
        end

        context 'when the value is not a time\'s representation' do
          let(:value) { 'string' }

          it 'should raise Sequel::InvalidValue' do
            expect { subject }.to raise_error(Sequel::InvalidValue)
          end
        end
      end

      context 'when the value is of Time' do
        before { subject }

        let(:value) { Time.now - 1 }

        it 'should set `created_at` attribute to the value' do
          expect(instance.created).to be_within(1).of(value)
        end
      end

      context 'when the value is nil' do
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end
  end

  describe '#destroy' do
    subject { instance.destroy }

    let!(:instance) { create(:genius) }

    it 'should destroy the record' do
      expect { subject }.to change { described_class.count }.by(-1)
    end
  end
end
