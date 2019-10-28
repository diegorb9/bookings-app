# frozen_string_literal: true

require 'rails_helper'

feature 'User sign in' do
  given!(:user) { create(:user) }

  before { visit new_user_session_path }

  scenario 'makes login with success' do
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password

    click_button 'Entrar'

    expect(page).to have_text('Logado com sucesso.')
  end

  scenario 'attempts login with incorrect password' do
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: 'foobar111'

    click_button 'Entrar'

    expect(page).to have_text('E-mail ou senha inválida.')
  end
end
