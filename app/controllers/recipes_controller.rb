class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def show
    @recipe = Recipe.find(params[:id])
  end

  def by_user
    @recipes = Recipe.where(user: current_user)
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
      render 'new'
    end
  end

  def edit
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
      render 'new'
    end
  end

  def search
    @search_term = params[:search]
    @recipes = Recipe.where(title: @search_term)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty,
                                  :cook_time, :ingredients, :method)
  end
end
