class PlannerMailer < ApplicationMailer
	default from: 'BudgetPlanner@gmail.com'

  def planner_notification
    @user = params[:recipient]
    mail(to: @user.email, subject: "You've reached the limit of your wallet.")
  end
end
