class TasksController < ApplicationController
  autocomplete :user, :email #, :scopes => [:scope1, :scope2]
  
  before_filter :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:update]

  # GET /tasks
  # GET /tasks.json
  def index
    
    @user  = get_user(params[:user_id].to_i)
    @tasks = @user.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.js  { render :json => @tasks.to_json }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params.merge(created_by: current_user.id ))

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
  
  # GET /tasks
  # GET /tasks.json
  def calendar
    
    @user  = params[:user_id].to_i == current_user.id ? current_user : User.find_by_id(params[:user_id].to_i)
    @tasks = @user.tasks.active

    respond_to do |format|
      format.html # index.html.erb
      format.js  { render :json => @tasks.to_json }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:created_by, :user_email, :title, :description, :start_date, :end_date, :status)
    end
end
