class ReviewsController < ApplicationController
  before_filter :check

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(params[:review].permit(:rating, :description))
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    end
  end

  def check
    unless current_user
      redirect_to product_path(@product)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to @review.product
  end
end
