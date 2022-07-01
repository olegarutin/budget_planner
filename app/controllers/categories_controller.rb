class CategoriesController < ApplicationController
  before_action :set_images, :set_categories, only: %i[create index]

  def new
    @category = Category.new
  end

  def index
    return unless Transaction::TYPES.include?(params[:transaction_type].to_sym)

    @categories = @categories.send(params[:transaction_type])
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        flash.notice = 'Category successfully created'

        format.turbo_stream { render :create }
      else
        format.turbo_stream { render :create, status: :found }
      end
    end
  end

  private

  def category_params
    params.permit(:title, :image, :transaction_type).merge(user: current_user)
  end

  def set_categories
    @categories = Category.all.where(user: [current_user, nil])
  end
end
