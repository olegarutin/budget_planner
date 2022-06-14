class PlannerMailer < ApplicationMailer
	default from: 'BudgetPlanner@gmail.com'

  def planner_notification
    #'emma.flores99.98@gmail.com'
    mail(to: current_user.email, subject: "You've reached the limit of your #{current_user.wallet.name} wallet.")
  end
end
