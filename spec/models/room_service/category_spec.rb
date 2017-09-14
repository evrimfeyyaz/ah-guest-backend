require 'rails_helper'

describe RoomService::Category do
  it { should have_many(:sections).dependent(:destroy).inverse_of(:category) }
  it { should have_attached_file(:image) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_attachment_content_type(:image).allowing('image/png', 'image/jpeg') }
  it { should validate_attachment_size(:image).in(0..2.megabytes) }

  describe '#after_create' do
    it 'creates the default section' do
      category = create(:room_service_category)

      expect(category.default_section).not_to be_nil
    end
  end

  describe '#available_at?' do
    context 'when #available_from and #available_until exist' do
      before(:each) do
        subject.available_from = Tod::TimeOfDay.new(8)
        subject.available_until = Tod::TimeOfDay.new(16)
      end

      context 'and given time object is within available hours' do
        it 'returns true' do
          time = DateTime.parse('2017-01-01 10:00:00')

          expect(subject.available_at?(time)).to be true
        end
      end

      context 'and given time object is outside available hours' do
        it 'returns false' do
          time = DateTime.parse('2017-01-01 17:00:00')

          expect(subject.available_at?(time)).to be false
        end
      end

      context 'and given time object is equal to #available_from' do
        it 'returns true' do
          time = DateTime.parse('2017-01-01 09:00:00')

          expect(subject.available_at?(time)).to be true
        end
      end

      context 'and given time object is equal to #available_until' do
        it 'returns true' do
          time = DateTime.parse('2017-01-01 16:00:00')

          expect(subject.available_at?(time)).to be true
        end
      end
    end

    context 'when #available_from does not exist' do
      it 'returns true' do
        subject.available_from = nil

        time = DateTime.parse('2017-01-01 09:00:00')

        expect(subject.available_at?(time)).to be true
      end
    end

    context 'when #available_until does not exist' do
      it 'returns true' do
        subject.available_until = nil

        time = DateTime.parse('2017-01-01 09:00:00')

        expect(subject.available_at?(time)).to be true
      end
    end

    context 'when #avaiable_from and #available_until do not exist' do
      it 'returns true' do
        subject.available_from = nil
        subject.available_until = nil

        time = DateTime.parse('2017-01-01 09:00:00')

        expect(subject.available_at?(time)).to be true
      end
    end

    context 'when #available_from is before midnight and #available_until is after midnight' do
      before(:each) do
        subject.available_from = DateTime.parse('2000-01-01 21:00:00')
        subject.available_until = DateTime.parse('2000-01-01 03:00:00')
      end

      context 'and given time is between those times' do
        it 'returns true' do
          time = DateTime.parse('2017-01-01 23:00:00')

          expect(subject.available_at?(time)).to be true
        end
      end

      context 'and given time is outside those times' do
        it 'returns false' do
          time = DateTime.parse('2017-01-01 04:00:00')

          expect(subject.available_at?(time)).to be false
        end
      end
    end
  end
end