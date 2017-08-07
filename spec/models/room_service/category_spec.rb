require 'rails_helper'

describe RoomService::Category do
  it { should have_many(:sub_categories).
    dependent(:destroy).
    inverse_of(:category).
    with_foreign_key('room_service_category_id') }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_attachment_content_type(:image).allowing('image/png', 'image/jpeg') }
  it { should validate_attachment_size(:image).less_than(2.megabytes) }

  context 'when created' do
    it 'creates a default sub-category' do
      category = create(:room_service_category)

      expect(category.default_sub_category).not_to be_nil
    end
  end

  describe '#available?' do
    context 'when #available_from and #available_until exist' do
      context 'and given time object is within available hours' do
        it 'returns true' do
          # Check out https://stackoverflow.com/questions/34978905/rails-activerecord-postgres-time-format
          # regarding why '2000-01-01' is used as the date.
          subject.available_from = DateTime.parse('2000-01-01 09:00:00')
          subject.available_until = DateTime.parse('2000-01-01 16:00:00')

          time = DateTime.parse('2017-01-01 10:00:00')

          expect(subject.available?(time)).to be true
        end
      end

      context 'and given time object is outside available hours' do
        it 'returns false' do
          subject.available_from = DateTime.parse('2000-01-01 09:00:00')
          subject.available_until = DateTime.parse('2000-01-01 16:00:00')

          time = DateTime.parse('2017-01-01 17:00:00')

          expect(subject.available?(time)).to be false
        end
      end

      context 'and given time object is equal to #available_from' do
        it 'returns true' do
          subject.available_from = DateTime.parse('2000-01-01 09:00:00')
          subject.available_until = DateTime.parse('2000-01-01 16:00:00')

          time = DateTime.parse('2017-01-01 09:00:00')

          expect(subject.available?(time)).to be true
        end
      end

      context 'and given time object is equal to #available_until' do
        it 'returns true' do
          subject.available_from = DateTime.parse('2000-01-01 09:00:00')
          subject.available_until = DateTime.parse('2000-01-01 16:00:00')

          time = DateTime.parse('2017-01-01 16:00:00')

          expect(subject.available?(time)).to be true
        end
      end
    end

    context 'when #available_from does not exist' do
      it 'returns true' do
        subject.available_from = nil
        subject.available_until = DateTime.parse('2000-01-01 16:00:00')

        time = DateTime.parse('2017-01-01 09:00:00')

        expect(subject.available?(time)).to be true
      end
    end

    context 'when #available_until does not exist' do
      it 'returns true' do
        subject.available_from = DateTime.parse('2000-01-01 09:00:00')
        subject.available_until = nil

        time = DateTime.parse('2017-01-01 09:00:00')

        expect(subject.available?(time)).to be true
      end
    end

    context 'when #avaiable_from and #available_to do not exist' do
      it 'returns true' do
        subject.available_from = nil
        subject.available_until = nil

        time = DateTime.parse('2017-01-01 09:00:00')

        expect(subject.available?(time)).to be true
      end
    end

    context 'when #available_from is before midnight and #available_until is after midnight' do
      context 'and given time is between those times' do
        it 'returns true' do
          subject.available_from = DateTime.parse('2000-01-01 21:00:00')
          subject.available_until = DateTime.parse('2000-01-01 03:00:00')

          time = DateTime.parse('2017-01-01 23:00:00')

          expect(subject.available?(time)).to be true
        end
      end

      context 'and given time is outside those times' do
        it 'returns false' do
          subject.available_from = DateTime.parse('2000-01-01 21:00:00')
          subject.available_until = DateTime.parse('2000-01-01 03:00:00')

          time = DateTime.parse('2017-01-01 04:00:00')

          expect(subject.available?(time)).to be false
        end
      end
    end
  end
end