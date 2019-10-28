# frozen_string_literal: true

class BookingsPresenter
  include Rails.application.routes.url_helpers

  def initialize(relation, date)
    @relation = relation
    @date = date.to_date
  end

  def records
    relation.where(date: beginning_of_week..end_of_week)
  end

  def beginning_of_week
    date.beginning_of_week
  end

  def end_of_week
    date.end_of_week - 2.days
  end

  def previous_link
    bookings_path(date: beginning_of_week - 1.week)
  end

  def next_link
    bookings_path(date: beginning_of_week + 1.week)
  end

  private

  attr_reader :relation, :date
end
