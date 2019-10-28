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
end
