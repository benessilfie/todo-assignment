class AuthController < ApplicationController
    
    def sign_in
    end
    
    def sign_up
    end

    def login 
    end

    def create_user
        user_params = params[:user].permit!
        user = User.create(user_params)

        redirect_to sign_in_path
    end
    
end
    