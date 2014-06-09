class ReceiptsReport
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

  def receipts
    Receipt.includes(member: :membership)
           .where('received_date between :s and :e', s: start_date, e: end_date)
  end

  def header
    [['ID',
      'Type',
      'Mode',
      'Member',
      'Gender',
      'Age Group',
      'Membership',
      'Status',
      'Received Date',
      'Amount',
      'Count'
     ]]
  end

  def rows
    receipts.map do |receipt|
      [receipt.id,
       receipt.kind.titleize,
       receipt.mode.titleize,
       receipt.member.name,
       receipt.member.gender.titleize,
       receipt.member.age_group.titleize,
       receipt.member.membership.name,
       receipt.status.titleize,
       receipt.received_date,
       receipt.amount,
       1
      ]
    end
  end
end
