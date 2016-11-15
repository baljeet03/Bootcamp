class TasksController < ApplicationController

  include TasksHelper
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.paginate(:page => params[:page],:per_page => 10)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    #
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.status="active"
    if @task.save
      flash[:success] = "Your new task has been created"
      redirect_to root_path
    else
      render "tasks/new"
    end
  end


  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    @task.status="active"
    if @task.update_attributes(params[:task])
      redirect_to show_path
    else render 'tasks/edit'
    end
  end
  #
  # # DELETE /tasks/1
  # # DELETE /tasks/1.json
  # def destroy
  #   # @task = Task.find(params[:id])
  #   # @task.destroy
  #   #
  #   # respond_to do |format|
  #   #   format.html { redirect_to tasks_url }
  #   #   format.json { head :no_content }
  #   # end
  # end
end
