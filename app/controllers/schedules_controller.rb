class SchedulesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

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
    @plan = Plan.create(plan_params)
    redirect_to new_schedule_path
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan).merge(user_id: current_user.id)
  end
end
