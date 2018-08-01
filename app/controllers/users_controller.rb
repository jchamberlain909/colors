class UsersController < ApplicationController
    def index
        render json: User.all, status: 200
    end

    def create
        user = User.find_or_create_by(params.require(:user).permit(:username))
        render json: user, status: 200
    end

    def update
        user = User.find(params[:id]).update(params.require(:user).permit(:totalPixels, :board_id))
        render json: user, status: 200
    end

end
