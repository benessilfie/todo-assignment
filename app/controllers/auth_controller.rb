class AuthController < ApplicationController
    
    def sign_in
    end
    
    def sign_up
    end

    def login 
    end

    def create_user
        user_params = params[:user].permit!

        respond_to do |format|
            if User.find_by(email: user_params[:email]).present?
                format.html {redirect_to sign_up_path, notice: "user with email already exists"}
            else
                user = User.create(user_params)
                if user.errors&.full_messages.present? 
                    format.html {redirect_to sign_up_path, notice: "#{user.errors.full_messages[0]}"}
                end
            end
        end
    end
    
end 
    