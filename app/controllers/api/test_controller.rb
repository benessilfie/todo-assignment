class Api::TestController < ApiController
  def index
    render json: { message: "Hello, World!" }
  end
end