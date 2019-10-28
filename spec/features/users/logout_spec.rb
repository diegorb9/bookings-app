# frozen_string_literal: true

require 'rails_helper'

feature 'User sign-out' do
  include_context 'Authenticated user'

  given!(:user) { create(:user) }

  scenario 'clicks sign-out link and redirect to root' do
    visit bookings_path

    click_link 'Sair'

    expect(page).to have_text('Você precisa entrar ou registrar-se antes de continuar.')
  end
end
