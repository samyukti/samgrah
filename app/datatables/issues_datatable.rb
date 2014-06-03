class IssuesDatatable < GenericDatatable
  private

  def data
    records.map do |issue|
      [issue.id,
       issue.item.name,
       issue.copy.name,
       issue.member.name,
       issue.issued_date,
       issue.return_date,
       issue.extension,
       issue.status.titleize,
       action_links(issue)
      ]
    end
  end

  def records
    @issues ||= Issue.all.includes(:item, :copy, :member)
    issues = @issues.order("#{sort_column} #{sort_direction}")
    issues = issues.page(page).per(per)
    if params[:search][:value].present?
      issues = issues.where("items.name ilike :search or copies.name ilike :search or members.name ilike :search", search: "%#{params[:search][:value]}%")
                   .references(:item, :copy, :member)
    end
    issues
  end

  def columns
    %w(issues.id issues.item issues.copy issues.member issues.issued_date issues.return_date issues.status)
  end
end
