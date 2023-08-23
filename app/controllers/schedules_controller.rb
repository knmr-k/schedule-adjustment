class SchedulesController < ApplicationController
  def index
    @date = Date.today
    @user_list = User.all
  end

  def new
    @date = Date.today
    @plan = Plan.new
    @plans = Plan.where(user_id: current_user.id)
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to new_schedule_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan).merge(user_id: current_user.id)
  end
end
