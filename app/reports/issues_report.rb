class IssuesReport
  def initialize(params = {})
    start_date  = params[:start_date] || Date.today.beginning_of_month.strftime('%F')
    end_date    = params[:end_date]   || Date.today.end_of_month.strftime('%F')

    @issues = Issue.where('issued_date between :s and :e', s: start_date, e: end_date)
  end

  def report
    @issues.page(params[:page])
  end
end
