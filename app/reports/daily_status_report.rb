class DailyStatusReport
  def initialize(params)
    @params = params
  end

  def report
    { date: date, issues: issues }
  end

  private

  def date
    @params[:date].presence || Date.today
  end

  def issues
    Issue.where(issued_date: date).page(@params[:page]).page(@params[:per])
  end
end
