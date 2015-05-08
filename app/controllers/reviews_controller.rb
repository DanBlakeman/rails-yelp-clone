class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)

    redirect_to restaurants_path
  end

  def destroy
    if current_user.reviews.include?(Review.find_by_id(params[:id]))
      current_user.reviews.destroy(params[:id])
      flash[:notice] = 'Review deleted'
    else
      flash[:notice] = 'fail'
    end
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
