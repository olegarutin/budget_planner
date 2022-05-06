class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)

    if @category.save
      redirect_to new_transaction_path
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to new_transaction_path
    else
      redirect_to edit_category_path(@category)
    end
  end

  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :image)
  end
end
