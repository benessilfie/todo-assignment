class Api::TestController < ApiController
  def index
    render json: { message: "Welcome to my Todo API!" }
  end
end