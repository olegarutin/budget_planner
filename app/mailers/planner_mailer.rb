class PlannerMailer < ApplicationMailer
	default from: 'BudgetPlanner@gmail.com'

  def planner_notification
    #@user = current_user
    mail(to: 'emma.flores99.98@gmail.com', subject: 'Order successfully created!')
  end
end
