# frozen_string_literal: true

require 'rails_helper'

feature 'Listing bookings' do
  include_context 'Authenticated user'

  given(:date) { '30/10/2019' }
  given(:user) { create(:user) }
  given!(:booking) { create(:booking, user: user, date: date, time: '08:00:00') }

  before { Timecop.freeze(date) }
  after { Timecop.return }

  background { visit bookings_path }

  scenario 'displays reserved text correctly' do
    expect(page).to have_text("Reservado para #{user.name}", count: 1)
  end
end
