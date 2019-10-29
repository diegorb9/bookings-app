# frozen_string_literal: true

require 'rails_helper'

feature 'Creating bookings', js: true do
  include_context 'Authenticated user'

  given!(:user) { create(:user) }

  background do
    Timecop.freeze('28/10/2019 01:00:00')

    visit bookings_path
  end

  after { Timecop.return }

  scenario 'opens modal, fills description and checks for success message' do
    within 'tr:nth-child(2) td:nth-child(2)' do
      click_link 'Disponível'
    end

    within '#modal' do
      expect(page).to have_text('Data') && have_text('28/10/2019')
      expect(page).to have_text('Horário') && have_text('07:00')

      fill_in 'Descrição', with: 'Example'

      click_button 'Reservar'
    end

    expect(page).to have_text('Reserva realizada com sucesso.')

    within 'tr:nth-child(2) td:nth-child(2)' do
      expect(page).to have_text('Reservado para John Doe')
    end
  end

  scenario 'opens modal, fills description and checks for error message' do
    within 'tr:nth-child(2) td:nth-child(2)' do
      click_link 'Disponível'
    end

    within '#modal' do
      expect(page).to have_text('Data') && have_text('28/10/2019')
      expect(page).to have_text('Horário') && have_text('07:00')

      fill_in 'Descrição', with: ''

      click_button 'Reservar'

      expect(page).to have_text('Descrição não pode ficar em branco')
    end
  end

  scenario 'opens the modal, clicks cancel and checks if the reservation available' do
    within 'tr:nth-child(2) td:nth-child(2)' do
      click_link 'Disponível'
    end

    within '#modal' do
      expect(page).to have_text('Data') && have_text('28/10/2019')
      expect(page).to have_text('Horário') && have_text('07:00')

      fill_in 'Descrição', with: 'Example'

      click_button 'Fechar'
    end

    expect(page).not_to have_text('Reserva realizada com sucesso.')

    within 'tr:nth-child(2) td:nth-child(2)' do
      expect(page).not_to have_text('Reservado para John Doe')
      expect(page).to have_text('Disponível')
    end
  end
end
