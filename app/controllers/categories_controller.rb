class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all.where(user: [current_user, nil]).send(params[:transaction_type])
  end

  def create
    @category = Category.new(category_params.merge(user: current_user))
    respond_to do |format|
      if @category.save
        format.turbo_stream { render :create }
      else
        format.turbo_stream { render :create, status: :found }
      end
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
    params.permit(:title, :image, :transaction_type)
  end
end
