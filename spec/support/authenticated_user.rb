# frozen_string_literal: true

RSpec.shared_context 'Authenticated user' do
  background { authenticate }

  def authenticate
    visit new_user_session_path

    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password

    click_button 'Entrar'
  end
end
