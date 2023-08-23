module SchedulesHelper

  def plan_check(num, user)
    plans = Plan.includes(:user)
    date = Date.today
    check_day = date.beginning_of_week + num
    plan_search = plans.select{|i| i.date == check_day && i.user_id == user.id}

    if plan_search == []
      "blank"
    elsif !user_signed_in?
      "???"
    elsif (current_user.id == plan_search[0].user_id) || current_user.admin == true
       "#{plan_search[0].plan}"
    else
      "???"
    end
  end

  def plan_result(num)
    plans = Plan.includes(:user)
    user_list = User.all
    date = Date.today
    check_day = date.beginning_of_week + num
    result = "OK"

    user_list.each do |user|
      plan_search = plans.select{|i| i.date == check_day && i.user_id == user.id}
      if plan_search == []
        result = "???"
        break
      elsif plan_search[0].plan == false
        result = "NO"
        break
      end
    end
    "#{result}"
  end

end
