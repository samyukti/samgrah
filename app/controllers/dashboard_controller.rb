class DashboardController < ApplicationController
  def index
    # build data for trend chart, considering weeks without any issues
    @trend = []
    issues = Issue.where(issued_date: 13.weeks.ago..Date.today)
                  .order('issued_date asc')
                  .group_by { |i| i.issued_date.beginning_of_week(:monday) }

    (13.weeks.ago.to_date..Date.current).select do |date|
      @trend.push([date.beginning_of_week(:monday).strftime('%m/%d'),
                   issues[date] ? issues[date].try(&:count) || 0 : 0]) \
        if date.monday?
    end

    # build data for pie chart
    share = Issue.open
                 .includes(item: :category)
                 .group_by { |i| i.item.category }
                 .map { |k, v| { label: k.name, data: v.count } }
    @share = (share.empty? ? [{}] : share).to_json
  end
end
