class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update]
  before_action :populates_var, only: [:show, :edit, :new]
  before_action :find_recipe, only: [:show, :edit]


  def favorite

    Favorite.create(user:current_user,recipe:Recipe.find(params[:id]))
    redirect_to favorites_recipes_path
  end

  def favorites
    redirect_to root_path unless current_user
  end

  def show

    if user_signed_in?
      @belongs_user = is_user_recipe
    end
  end

  def by_user
    @recipes = Recipe.where(user: current_user)
  end

  def index
    @recipes = Recipe.all
  end

  def new
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
    redirect_to root_path unless  is_user_recipe
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

  def is_user_recipe
    current_user.recipes.include?(@recipe)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])

  end

  def populates_var
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end
