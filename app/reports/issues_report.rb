class IssuesReport
  def initialize(params)
    @params = params
  end

  def report
    { start_date: start_date, end_date: end_date, rows: header + rows }
  end

  private

  def start_date
    @params[:start_date].presence || Date.today.beginning_of_month.strftime('%F')
  end

  def end_date
    @params[:end_date].presence || Date.today.end_of_month.strftime('%F')
  end

  def issues
    Issue.includes(:copy)
         .includes(item: :category)
         .includes(member: :membership)
         .where('issued_date between :s and :e', s: start_date, e: end_date)
  end

  def header
    [['ID',
      'Copy',
      'Item',
      'Category',
      'Type',
      'Language',
      'Member',
      'Gender',
      'Age Group',
      'Membership',
      'Status',
      'Issued Date',
      'Return Date',
      'No of Days',
      'Count'
     ]]
  end

  def rows
    issues.map do |issue|
      [issue.id,
       issue.copy.name,
       issue.item.name,
       issue.item.category.name,
       issue.item.kind.titleize,
       issue.item.language.titleize,
       issue.member.name,
       issue.member.gender.titleize,
       issue.member.age_group.titleize,
       issue.member.membership.name,
       issue.status.titleize,
       issue.issued_date,
       (issue.returned_date || issue.return_date),
       ((issue.returned_date || Date.today) - issue.issued_date).to_i,
       1
      ]
    end
  end
end
