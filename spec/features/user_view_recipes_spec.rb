require 'rails_helper'

feature 'User view your recipes' do
  scenario 'successfully' do
    user = User.create(email:'joao@campus.com', password:'123456')
    brazilian_cuisine= Cuisine.create(name:'Brasileira')
    brazilian_type= RecipeType.create(name:'Entrada')
    recipe = Recipe.create(title: 'Bolo',recipe_type:brazilian_type,
    cuisine:brazilian_cuisine,difficulty:'facil',cook_time:10,
    ingredients:'farinha e ovos',method:'misture a farinha com ovos',
    user: user)

    visit root_path
    click_on 'Login'

    fill_in 'Email', with: 'joao@campus.com'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'

    click_on 'Minhas receitas'

    expect(page).to have_css('h1', text:'Minhas receitas')
    expect(page).to have_css('h1', text:'Bolo')
    expect(page).to have_css('p', text:'Brasileira')
    expect(page).to have_css('p', text:'facil')
    expect(page).to have_css('p', text:'Tempo de preparo: 10')

  end

end
