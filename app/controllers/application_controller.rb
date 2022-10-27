class ApplicationController < ActionController::Base
    before_action :authenticate_user, 

    def authenticate_user
        @user = User.find(session[:user]) if session[:user]
        @current_user = @user.present?
    end

    def requires_sign_in
        redirect_to sign_in_path, notice: "Please sign in" unless @current_user
    end

    def requires_sign_out
        redirect_to todos_path, notice: "You are already signed in" if @current_user
    end

end
