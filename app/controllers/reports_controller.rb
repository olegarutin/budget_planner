require 'pdfcrowd'

class ReportsController < ApplicationController
  def index
    @transaction_type = params[:transaction_type] || 'expense'
    @start_date = params[:start_date] || 7.days.ago.to_date.to_s
    @end_date = params[:end_date] || Date.tomorrow.to_date.to_s
    respond_to do |format|
      format.html
      format.pdf do
        begin
        client = Pdfcrowd::HtmlToPdfClient.new(ENV['PDFCROWD_USERNAME'], ENV['PDFCROWD_API_KEY'])

        pdf = client.convertUrl("https://budget--planner.herokuapp.com/reports")

        send_data pdf,
                  :type => "application/pdf",
                  :disposition => "attachment; filename*=UTF-8''#{ERB::Util.url_encode('result.pdf')}"
        rescue Pdfcrowd::Error => why
          render plain: why.getMessage(), status: why.getCode()
        end
      end
    end


    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     render pdf: "Report from #{Date.current}", template: "reports/index", formats: [:html],
    #     orientation: "landscape", page_size: "A4", javascript_delay: 1000, view_as_html: false
    #   end

    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     pdf = Prawn::Document.new
    #     send_data pdf.render, filename: "Report from #{Date.current}",
    #                           type: "application/pdf",
    #                           disposition: "inline"
    #   end
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
