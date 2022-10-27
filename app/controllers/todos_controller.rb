class TodosController < ApplicationController
  before_action :requires_sign_in, except: [:home]
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    @todos = @user.todos.all
  end

  def home
  end

  # GET /todos/1 or /todos/1.json
  def show
    @todo = Todo.find(params[:id])
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    @todo = @user.todos.create(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_path , notice: "Todo was successfully created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    redirect_to todos_path, notice: "Todo was successfully deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.fetch(:todo, {})
      params.require(:todo).permit(:description)
    end
end
