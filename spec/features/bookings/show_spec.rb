# frozen_string_literal: true

require 'rails_helper'

feature 'Showing a booking' do
  include_context 'Authenticated user'

  given(:date) { '28/10/2019' }
  given(:user) { create(:user) }
  given!(:booking) { create(:booking, user: user, date: date, time: '06:00') }

  before { Timecop.freeze(date) }
  after { Timecop.return }

  background { visit bookings_path }

  scenario 'displays booking details', js: true do
    within 'tr:nth-child(1) td:nth-child(2)' do
      expect(page).to have_text("Reservado para #{user.name}")

      find("#show-#{booking.id}").click
    end

    within '#modal' do
      expect(page).to have_text('Data:') && have_text('28/10/2019')
      expect(page).to have_text('Horário:') && have_text('06:00')
      expect(page).to have_text('Descrição:') && have_text('Foo bar')
    end
  end
end
