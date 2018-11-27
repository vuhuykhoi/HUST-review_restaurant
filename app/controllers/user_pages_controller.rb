class UserPagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @followed_users=current_user.following
        @follower_users=current_user.followers
        @reviews = current_user.reviews
    end
    
    def following
    	@user = User.find(params[:id])
    	@followed_users = @user.following
        

        respond_to do |format|
            format.json {render json: @followed_users}
        end
    end

    def followers
    	@user = User.find(params[:id])
    	@follower_users = @user.followers
       
        respond_to do |format|
            format.json {render json: @followed_users}
        end
         
    end

end
