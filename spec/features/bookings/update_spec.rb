# frozen_string_literal: true

require 'rails_helper'

feature 'Updating a booking', js: true do
  include_context 'Authenticated user'

  given(:date) { '28/10/2019' }
  given(:user) { create(:user) }
  given(:user1) { create(:user, email: 'another@example.com', name: 'James') }
  given!(:booking) { create(:booking, user: user, date: date, time: '06:00') }
  given!(:booking1) { create(:booking, user: user1, date: date, time: '07:00') }

  background do
    Timecop.freeze(date)
    visit bookings_path
  end

  after { Timecop.return }

  scenario 'displays link to show modal when can update' do
    within 'tr:nth-child(1) td:nth-child(2)' do
      expect(page).to have_text("Reservado para #{user.name}")

      find("#edit-#{booking.id}").click
    end

    within '#modal' do
      expect(page).to have_text('Data:') && have_text('28/10/2019')
      expect(page).to have_text('Horário:') && have_text('06:00')
      expect(page).to have_text('Descrição:') && have_text('Foo bar')
    end
  end

  scenario "displays link to show modal when can't update" do
    within 'tr:nth-child(2) td:nth-child(2)' do
      expect(page).to have_text("Reservado para #{user1.name}")

      find("#show-#{booking1.id}").click
    end

    within '#modal' do
      expect(page).to have_text('Data:') && have_text('28/10/2019')
      expect(page).to have_text('Horário:') && have_text('07:00')
      expect(page).to have_text('Descrição:') && have_text('Foo bar')
    end
  end
end
