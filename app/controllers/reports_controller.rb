class ReportsController < ApplicationController
  def index
    @transaction_type = params[:transaction_type] || 'expense'
    @start_date = params[:start_date] || 7.days.ago.to_date.to_s
    @end_date = params[:end_date] || Date.tomorrow.to_date.to_s
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Report from #{Date.current}", template: "reports/index", formats: [:html]
      end
    end
  end
end
