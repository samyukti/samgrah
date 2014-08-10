class ReportsController < ApplicationController
  REPORTS = %w(overdue_issues expired_memberships
               copies issues receipts reservations daily_status)

  def index
  end

  def show
    fail ActionController::RoutingError, 'Report Not Found' \
      unless REPORTS.include? params[:report_name]

    @data = "#{params[:report_name]}_report".classify.constantize.new(params).report

    respond_to do |format|
      format.html { render template: "reports/#{params[:report_name]}" }
    end
  end

  private

  def report_params
    params.require(:report).permit(:issue_id, :reservation_id,
                                   :category_id, :item_id, :copy_id,
                                   :membership_id, :member_id,
                                   :status, :date, :start_date, :end_date)
  end
end
