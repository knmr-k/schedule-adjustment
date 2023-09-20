module SchedulesHelper

  # 予定を表示する機能
  def plan_check(num, user)
    date = Date.today
    check_day = date.beginning_of_week + num
    plan_search = Plan.find_by(date: check_day, user_id: user.id)

    if plan_search == nil
      render inline: "<div class=\"plan-blank\">-</div>"
    elsif !user_signed_in?
      render inline: "<div class=\"plan-que\">✅</div>"
    elsif (current_user.id == plan_search.user_id) || (current_user.admin == true)
      if plan_search.plan == true
        render inline: "<div class=\"plan-ok\">⭕</div>"
      elsif plan_search.plan == false
        render inline: "<div class=\"plan-no\">❌</div>"
      end
    else
      render inline: "<div class=\"plan-que\">✅</div>"
    end
  end

  # 予定に応じた結果を表示する機能
  def plan_result(num)
    user_list = User.all
    date = Date.today
    check_day = date.beginning_of_week + num
    result = "<div class=\"plan-ok\">⭕</div>"

    user_list.each do |user|
      plan_search = Plan.find_by(date: check_day, user_id: user.id)
      if plan_search == nil
        result = "<div class=\"plan-blank\">❓</div>"
        break
      elsif plan_search.plan == false
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
