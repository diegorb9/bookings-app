# frozen_string_literal: true

require 'rails_helper'

feature 'User sign up' do
  before { visit new_user_registration_path }

  scenario 'fills the fields correctly and show success message' do
    fill_in 'Nome', with: 'John Doe'
    fill_in 'E-mail', with: 'john@example.com'
    fill_in 'Senha', with: 'foobar123'
    fill_in 'Confirmação da Senha', with: 'foobar123'

    click_button 'Cadastrar'

    expect(page).to have_text('Bem-vindo! Você se registrou com êxito.')
  end

  scenario "doesn't fill the fields and show error message" do
    click_button 'Cadastrar'

    expect(page).to have_text('E-mail não pode ficar em branco') &&
                    have_text('Senha não pode ficar em branco') &&
                    have_text('Nome não pode ficar em branco')
  end
end
