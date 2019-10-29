# frozen_string_literal: true

require 'rails_helper'

feature 'Destroying bookings', js: true do
  include_context 'Authenticated user'

  given!(:user) { create(:user) }
  given!(:booking) { create(:booking, date: '28/10/2019', time: '06:00:00', user: user) }

  background do
    Timecop.freeze('28/10/2019 05:00')
    visit bookings_path
  end

  scenario 'clicks at button and check for a success message' do
    within 'tr:nth-child(1) td:nth-child(2)' do
      find("#destroy-#{booking.id}").click
    end

    page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Reserva deletada com sucesso.')

    within 'tr:nth-child(1) td:nth-child(2)' do
      expect(page).to have_text('Disponível')
    end
  end
end
