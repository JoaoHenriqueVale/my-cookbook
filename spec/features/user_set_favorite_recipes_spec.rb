require 'rails_helper'

feature 'User favorite recipe' do
  scenario 'successfully' do
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'rogerio.bispo@yahoo.com.br',password: '123456')

    appetizer_type = RecipeType.create(name: 'Entrada')
    main_type = RecipeType.create(name: 'Prato Principal')
    dessert_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                          cuisine: arabian_cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

  visit root_path
  click_on 'Bolodecenoura'
  click_on 'Favoritar'

  expect(page).to have_css('h1',text:'Minhas Receitas Favoritas')
  expect(page).to have_css('p',text:'Bolodecenoura')

  end
end
