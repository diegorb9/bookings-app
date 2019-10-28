# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingsPresenter do
  let(:relation) { double(:relation) }
  let(:date)     { '30/10/2019' }

  subject(:presenter) { described_class.new(relation, date) }

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
      expect(presenter.current_week_link).to eql('/bookings?date=2019-10-28')
    end
  end

  describe '#listable_hours' do
    it 'returns a collection of formatted hours' do
      expect(presenter.listable_hours).to eql(%w[
                                                06:00:00 07:00:00 08:00:00 09:00:00 10:00:00 11:00:00 12:00:00 13:00:00
                                                14:00:00 15:00:00 16:00:00 17:00:00 18:00:00 19:00:00 20:00:00 21:00:00
                                                22:00:00 23:00:00
                                              ])
    end
  end
end
