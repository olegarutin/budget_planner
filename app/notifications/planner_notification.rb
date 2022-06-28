class PlannerNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "PlannerMailer"

  param :planner
end
