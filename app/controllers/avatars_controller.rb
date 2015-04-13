class AvatarsController < ApplicationController
  def show
  end

  def create
    Avatar.all.where(user_id: params[:user_id]).each do |avatar|
      avatar.destroy
    end
    Avatar.create avatar_params
    redirect_to url_for(user_path current_user), turbolinks: true
  end

  def avatar_params
    p = params.require(:avatar).permit :image
    p[:user_id] = current_user.id
    p
  end
end
