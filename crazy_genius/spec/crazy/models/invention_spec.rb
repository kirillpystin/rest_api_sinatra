# frozen_string_literal: true

require_relative '../../spec_helper'

# Тесты для модели Invent
RSpec.describe Crazy::Models::Invent do
  describe 'the model' do
    subject { described_class }

    it { is_expected.to respond_to(:new, :create) }
  end

  describe '.new' do
    subject(:result) { described_class.new(params) }

    describe 'result' do
      subject { result }

      let(:params) { attributes_for(:invent).except(:id) }
      it { is_expected.to be_an_instance_of(described_class) }
    end
  end

  describe '.create' do
    subject(:result) { described_class.create(params) }

    describe 'result' do
      subject { result }
      let(:params) { attributes_for(:invent) }
      it { is_expected.to be_a(described_class) }
    end

    context 'when value of `power` property is nil' do
      let(:params) { attributes_for(:invent, power: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end

    context 'when value of `power` property is a negative number' do
      let(:params) { attributes_for(:invent, power: value) }
      let(:value) { -1 }

      it 'should raise Sequel::CheckConstraintViolation' do
        expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
      end
    end
  end

  describe 'instance of the model' do
    subject(:instance) { create(:invent) }

    messages = %i[id name power created_at genius_id update destroy]
    it { is_expected.to respond_to(*messages) }
  end

  describe '#id' do
    subject(:result) { instance.id }

    describe 'result' do
      subject { result }

      let(:instance) { create(:invent) }

      it { is_expected.to be_a(String) }
      it { is_expected.to match_uuid_format }
    end
  end

  describe '#name' do
    subject(:result) { instance.name }

    let(:instance) { create(:invent) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(String) }
    end
  end

  describe '#power' do
    subject(:result) { instance.power }

    let(:instance) { create(:invent) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_an(Integer) }
      it { is_expected.to be >= 0 }
    end
  end

  describe '#created_at' do
    subject(:result) { instance.created_at }

    let(:instance) { create(:invent) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(Time) }
    end
  end

  describe '#genius_id' do
    subject(:result) { instance.genius_id }

    describe 'result' do
      subject { result }

      let(:instance) { create(:invent) }

      it { is_expected.to be_a(String) }
      it { is_expected.to match_uuid_format }
    end
  end

  describe '#update' do
    subject(:result) { instance.update(params) }

    let(:instance) { create(:invent) }

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

    context 'when `created_at` property is present in parameters' do
      let(:params) { { created_at: value } }

      context 'when the value is of String' do
        context 'when the value is a time\'s representation' do
          before { subject }

          let(:value) { created_at.to_s }
          let(:created_at) { Time.now - 1 }

          it 'should set `created_at` attribute to the date' do
            expect(instance.created_at).to be_within(1).of(created_at)
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
          expect(instance.created_at).to be_within(1).of(value)
        end
      end

      context 'when the value is nil' do
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end

    context 'when `genius_id` property is present in parameters' do
      let(:params) { { genius_id: value } }

      context 'when the value is of String' do
        context 'when the value is an UUID' do
          context 'when the value is not a primary key' do
            let(:value) { create(:uuid) }

            it 'should raise Sequel::ForeignKeyConstraintViolation' do
              expect { subject }
                .to raise_error(Sequel::ForeignKeyConstraintViolation)
            end
          end

          context 'when the value is a primary key' do
            before { subject }

            let(:value) { create(:genius).id }

            it 'should set `genius_id` attribute to the value' do
              expect(instance.genius_id).to be == value
            end
          end
        end

        context 'when the value isn\'t an UUID' do
          let(:value) { 'isn\'t an UUID' }

          it 'should raise Sequel::DatabaseError' do
            expect { subject }.to raise_error(Sequel::DatabaseError)
          end
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

    let!(:instance) { create(:invent) }

    it 'should destroy the record' do
      expect { subject }.to change { described_class.count }.by(-1)
    end
  end
end
