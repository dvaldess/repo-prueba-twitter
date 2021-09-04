class FollowsController < ApplicationController
    #Metodo para seguir
    def to_follow
        @followed = User.find(params[:id])
        new_follow = Follow.create!(follower: current_user, followed: @followed)    
        redirect_to root_path
    end
    #Metodo para dejar de seguir
    def to_unfollow
        @followed = User.find(params[:id])
        current_user.followeds.find_by(followed_id: @followed.id).destroy
        redirect_to root_path
    end
end
