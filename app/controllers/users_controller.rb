    class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.email.blank?
            flash[:danger] = "Please enter email!"
            redirect_to root_path
        elsif @user.save
          flash[:success] = "Subscribe successfully!"
          redirect_to root_path
        else
          flash[:danger] = "You have subscribed!"
          redirect_to root_path
        end
      end

    def destroy
        user = User.find_by(email: params[:email])
        if params[:email].present?
            if user.present?
                flash[:success] = "Unsubscribe successfully!"
                user.destroy
                redirect_to root_path
            else
                flash[:danger] = "You haven't subscribed!"
                redirect_to root_path
            end
        else
            flash[:danger] = "Please enter email!"
            redirect_to root_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:email)
    end
end
