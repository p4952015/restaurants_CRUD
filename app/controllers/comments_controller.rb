class CommentsController < ApplicationController
  before_action :check_user

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.new(comment_params) #comment_params在private裡

    # @comment.user = current_user #改成17行的merge

    if @comment.save
      redirect_to restaurant_path(@restaurant) #餐廳的show
    else
      render 'restaurant/show'
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge({user: current_user})
  end

end