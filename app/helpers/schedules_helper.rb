module SchedulesHelper

  def plan_check(num, user)
    plans = Plan.includes(:user)
    date = Date.today
    check_day = date.beginning_of_week + num
    plan_search = plans.select{|i| (i.date == check_day) && (i.user_id == user.id)}

    if plan_search == []
      render inline: "<div class=\"plan-blank\">-</div>"
    elsif !user_signed_in?
      render inline: "<div class=\"plan-que\">✅</div>"
    elsif (current_user.id == plan_search[0].user_id) || (current_user.admin == true)
      if plan_search[0].plan == true
        render inline: "<div class=\"plan-ok\">⭕</div>"
      elsif plan_search[0].plan == false
        render inline: "<div class=\"plan-no\">❌</div>"
      end
    else
      render inline: "<div class=\"plan-que\">✅</div>"
    end
  end

  def plan_result(num)
    plans = Plan.includes(:user)
    user_list = User.all
    date = Date.today
    check_day = date.beginning_of_week + num
    result = "<div class=\"plan-ok\">⭕</div>"

    user_list.each do |user|
      plan_search = plans.select{|i| i.date == check_day && i.user_id == user.id}
      if plan_search == []
        result = "<div class=\"plan-blank\">❓</div>"
        break
      elsif plan_search[0].plan == false
        result = "<div class=\"plan-no\">❌</div>"
      end
    end
    render inline: result
  end

  def week_jp(day)
    days = ["月", "火", "水", "木", "金", "土", "日"]
    days[day]
  end

end
