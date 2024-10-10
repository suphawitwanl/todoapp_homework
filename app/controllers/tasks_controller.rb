class TasksController < ApplicationController
  def index
    @task = Task.new
    @last_task = Task.last
    @all_tasks = Task.where(status: 'incomplete').order(created_at: :asc)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      @last_task = Task.last
      render :index
    end
  end

  def completed_tasks
    @task = Task.new
    @last_task = Task.last
    @all_tasks = Task.where(status: 'complete').order(created_at: :asc)
    render :index
  end

  def complete
    @task = Task.find(params[:id])
    if @task.update(:status => 'complete')
      redirect_to tasks_path
    else
      render :edit
    end
  end



  private

  def task_params
    params.require(:task).permit(:name, :status)
  end
end
