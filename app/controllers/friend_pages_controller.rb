class FriendPagesController < ApplicationController
  def index
    @friend_user = User.find(params[:id])
    @followed_users=@friend_user.following
    @follower_users=@friend_user.followers
    @reviews = @friend_user.reviews.paginate(page: params[:page], per_page: 5).order('created_at DESC')

    respond_to do |format|
        format.html
        format.js
    end
  end
end
