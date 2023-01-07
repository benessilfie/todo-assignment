class Api::TodosController < ApiController
  before_action :authenticate
  before_action :validate_params, only: [:create, :update]
  before_action :set_todo, only: [:update, :destroy]

  def index
    todos = @user.todos.order(created_at: :desc)
    return render json: {
      message: 'Todos were fetched successfully',
      data: todos
    }
  end

  def show
    todo = @user.todos.find(params[:id])
    return render json: {
        message: 'Todo was fetched successfully',
        data: todo
    }
    end

  def create
    # return render json: { message: 'OK' }, status: :ok
    todo = Todo.create({ **@todo_params.except(:user_id), user: @user })
    if todo.errors.blank?
      return render json: {
        message: 'Todo was created successfully',
        data: todo
      }, status: :created
    else
      return render json: {
        message: todo.errors.full_messages.first || 'There was an error creating todo'
      }, status: :bad_request
    end
  end

  def update
    @todo.update({ **@todo_params.except(:user_id) })
    if @todo.errors.blank?
      return render json: {
        message: 'Todo was updated successfully',
        data: @todo
      }, status: :ok
    else
      return render json: {
        message: @todo.errors.full_messages.first || 'There was an error creating todo'
      }, status: :bad_request
    end
  end

  def destroy
    @todo.destroy
    return render json: {
      message: 'Todo was deleted successfully',
      data: @todo
    }, status: :ok
  end

  private

  def set_todo
    return render json: { message: 'No id in the params' }, status: :bad_request if params['id'].blank?

    @todo = Todo.find(params['id'])
  end

  def validate_params
    status = params.require(:status)

    if Todo.statuses.keys.exclude?(status)
      return render json: { message: 'Status should be either Pending, Completed or Cancelled' }
    end

    @todo_params = {
      status: status,
      description: params.require(:description)
    }
  end
end