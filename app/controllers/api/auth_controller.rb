class Api::AuthController < ApiController
    def register
        if User.find_by(email: register_params[:email]).present?
            message = 'Email address already exists'
            render json: { message: message }, status: :bad_request
        else
            user = User.create(register_params)
            if user.errors&.full_messages.present?
                message = user.errors&.full_messages.first
                render json: { message: message }, status: bad_request
            else
                render json: { message: "User was created" }, status: :created
            end
        end
    end

    def login
        email = params.require(:email)
        password = params.require(:password)

        user = User.find_by(email: email)

        if user.present?
            if user.authenticate(password)
                data = { id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email }
                token = TokenService.generate_token(data)

                render json: { message: 'Login successful', data: { **data, token: token } }
            else
                render json: {message: 'Password is incorrect'}, status: :unauthorized
            end
        else
            render json: {message: 'User with email does not exist'}, status: :not_found
        end
    end

    def register_params
        {
            email: params.require(:email),
            first_name: params.require(:first_name),
            last_name: params.require(:last_name),
            password: params.require(:password)
        }
    end
end