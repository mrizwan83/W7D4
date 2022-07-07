class GoalsController < ApplicationController
  before_action :require_current_user

  def new 
    @goal = Goal.new 
    render :new 
  end


  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id 
    if @goal.save 
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new 
    end
  end

  def index 
    @goals = current_user.goals
    render :index
  end

  def show 
    @goal = Goal.find(params[:id])
    render :show
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update 
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
       redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit 
    end
  end

  def destroy 
    @goal = Goal.find(params[:id])
    if @goal && @goal.destroy
      redirect_to goals_url
    end
  end

private 

  def goal_params
    params.require(:goal).permit(:title, :details, :private, :completed)
  end

end
