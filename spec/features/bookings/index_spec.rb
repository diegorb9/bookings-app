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

  scenario 'paginates to previous week', js: true do
    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('28/10/2019')
    end

    find('#previous_week').click

    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('21/10/2019')
    end

    find('#previous_week').click

    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('14/10/2019')
    end
  end

  scenario 'paginates to next week', js: true do
    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('28/10/2019')
    end

    find('#next_week').click

    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('04/11/2019')
    end

    find('#next_week').click

    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('11/11/2019')
    end
  end

  scenario 'paginates to current week', js: true do
    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('28/10/2019')
    end

    find('#next_week').click

    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('04/11/2019')
    end

    find('#current_week').click

    within 'tr:nth-child(1) th:nth-child(2)' do
      expect(page).to have_text('28/10/2019')
    end
  end
end
