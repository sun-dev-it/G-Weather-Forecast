    class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_path
        end
    end

    def destroy
        user = User.find_by(email: params[:email])
        if user.present?
          user.destroy
          redirect_to root_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:email)
    end
end