class DashboardController < ApplicationController
  def index
    redirect_to :welcome if cannot? :read, :dashboard

    @open_issues = Issue.open.count
    @issues_30_days = Issue.where(issued_date: 30.days.ago..Date.today).count
    @open_reservations = Reservation.open.count
    @overdue_issues = Issue.open.overdue.count

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

  def welcome
    @items = Item.page(params[:page]).per(12)
  end
end
