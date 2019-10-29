# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingsPresenter do
  let(:relation) { double(:relation) }
  let(:date)     { '30/10/2019' }

  subject(:presenter) { described_class.new(relation, date) }

  before { Timecop.freeze('30/10/2019 08:00:00') }
  after { Timecop.return }

  describe '#records' do
    it 'returns relation scoped by date' do
      expect(relation).to receive(:where)
        .once.with(date: ('2019-10-28'.to_date)..('2019-11-01'.to_date))
        .and_return(relation)

      expect(presenter.records).to eql(relation)
    end
  end

  describe '#beginning_of_week' do
    it 'returns the date corresponding to monday of the base date' do
      expect(presenter.beginning_of_week).to eql('28/10/2019'.to_date)
    end
  end

  describe '#end_of_week' do
    it 'returns the date corresponding to friday of the base date' do
      expect(presenter.end_of_week).to eql('01/11/2019'.to_date)
    end
  end

  describe '#previous_link' do
    it 'returns index path with last week date' do
      expect(presenter.previous_link).to eql('/bookings?date=2019-10-21')
    end
  end

  describe '#next_link' do
    it 'returns index path with next week date' do
      expect(presenter.next_link).to eql('/bookings?date=2019-11-04')
    end
  end

  describe '#current_week_link' do
    it 'returns index path with current week date' do
      expect(presenter.current_week_link).to eql('/bookings?date=2019-10-30')
    end
  end

  describe '#listable_hours' do
    let(:hours) do
      %w[
        06:00 07:00 08:00 09:00 10:00 11:00 12:00 13:00 14:00 15:00 16:00 17:00
        18:00 19:00 20:00 21:00 22:00 23:00
      ]
    end

    it 'returns a collection of formatted hours' do
      expect(presenter.listable_hours).to eql(hours)
    end
  end

  describe '#reservation_text' do
    let(:user) { double(:user, name: 'John Doe') }
    let(:booking) { double(:booking, user: user) }

    it 'returns correct text' do
      expect(
        presenter.reservation_text(booking)
      ).to eql('Reservado para <b>John Doe</b>')
    end
  end

  describe '#availability_text' do
    context 'when the period is before now' do
      it 'returns default text' do
        expect(
          presenter.availability_text('20/10/2019', '10:00:00')
        ).to eql('-')
      end
    end

    context 'when the period is after now' do
      it 'returns default text' do
        expect(
          presenter.availability_text('01/11/2019', '09:00:00')
        ).to eql('<a class="link" data-remote="true" href="/bookings/new?date=01%2F11%2F2019&amp;time=09%3A00">Disponível</a>')
      end
    end
  end
end
