class ReviewsController < ApplicationController

  # def create
  #   render text: params[:review].inspect
  # end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(params[:review].permit(:rating, :description))
    @review.user = current_user
    @review.save
    redirect_to product_path(@product)

  end
end
