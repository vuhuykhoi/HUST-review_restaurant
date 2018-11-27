class Follow < ActiveRecord::Base
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    
    validates :follower_id , presence: true
    validates :followed_id , presence: true
    # def create
    #     Follow.create(create_params)
    #     redirect_to controller: 'users',action: 'index'
    # end
    
    # def destroy
    #     follow = Follow.find(params[:id])
    #     follow.destroy
    #     redirect_to controller: 'users',action: 'index'
    # end
    
    # private
    
    # def create_params
    #     params.permit(:followed_id).merge(follower_id: current_user.id)
    # end
end
