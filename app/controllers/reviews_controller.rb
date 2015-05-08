class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    unless current_user.has_reviewed?(@restaurant)
      temp = review_params
      temp[:restaurant_id] = params[:restaurant_id]
      current_user.reviews.create(temp)
    else
      flash[:notice] = 'Sorry you have reviewed this restaurant already'
    end
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
