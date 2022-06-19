class ReportsController < ApplicationController
  def index
    @transaction_type = params[:transaction_type] || 'expense'
    @start_date = params[:start_date] || 7.days.ago.to_date.to_s
    @end_date = params[:end_date] || Date.tomorrow.to_date.to_s
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Report from #{Date.current}", template: "reports/index", formats: [:html],
        orientation: "landscape", page_size: "A4", javascript_delay: 10000, view_as_html: false
      end

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     pdf = Prawn::Document.new
    #     send_data pdf.render, filename: "Report from #{Date.current}",
    #                           type: "application/pdf",
    #                           disposition: "inline"
    #   end
    end
  end

  # def pdf
    # renderer = ApplicationController.renderer.new(
    #   http_host: "http://localhost:3000/"
    # )

  #   html = ApplicationController.renderer.new.render_to_string(
  #     "reports/index", # Any view within your app
  #   )

  #   #html = Grover::HTMLPreprocessor.process html

  #   Grover.new(html, {
  #     format: "A4", # Many other options are available
  #     emulate_media: "screen",
  #     scale: 0.9    # This helped me to get the PDF displayed correctly on A4 format
  #   }).to_pdf
  # end
end
