class OverdueIssuesReport
  def initialize(params)
    @params = params
  end

  def report
    { issues: issues }
  end

  private

  def issues
    Issue.overdue.page(@params[:page]).page(@params[:per])
  end
end
