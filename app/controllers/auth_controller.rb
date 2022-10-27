class AuthController < ApplicationController
    before_action :requires_sign_out, except: [:logout]
    before_action :requires_sign_in, only: [:logout]
    
    def sign_in
    end
    
    def sign_up
    end

    def login
        credentials = params[:credentials]
        user = User.find_by(email: credentials[:email])

         respond_to do |format|
            if user.present?
                if user.authenticate(credentials[:password])
                    session[:user] = user.id
                    format.html { redirect_to todos_path, notice: "Successfully logged in 🎉"}
                else
                    format.html {redirect_to sign_in_path, notice: "Password is incorrect"}
                end
            elsif !user.present?
                format.html {redirect_to sign_in_path, notice: "user with email does not exists"}
            end
        end
    end

    def create_user
        user_params = params[:user].permit!

        respond_to do |format|
            if User.create(user_params)
                format.html { redirect_to sign_in_path, notice: "User successfully created" }
            else
                user = User.create(user_params)
                if user.errors&.full_messages.present? 
                    format.html {redirect_to sign_up_path, notice: "#{user.errors.full_messages[0]}"}
                end
            end
        end
    end

    def logout
        session[:user] = nil
        redirect_to sign_in_path, notice: "Successfully logged out"
    end
    
end 
    