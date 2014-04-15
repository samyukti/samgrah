class ReportsController < ApplicationController
  def index
  end

  def issues
    @issues = IssuesReport.new(params).report
    respond_to do |format|
      format.html
    end
  end

  def reservations
    @reservations = ReservationsReport.new.report
    respond_to do |format|
      format.html
    end
  end

  private

  def report_params
    params.require(:report).permit(:issue_id, :reservation_id,
                                   :category_id, :item_id, :copy_id,
                                   :membership_id, :member_id,
                                   :status, :start_date, :end_date)
  end
end
