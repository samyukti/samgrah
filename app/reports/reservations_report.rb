class ReservationsReport
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

  def reservations
    Reservation.includes(item: :category)
               .includes(member: :membership)
               .where('reserved_date between :s and :e', s: start_date, e: end_date)
  end

  def header
    [['ID',
      'Item',
      'Category',
      'Type',
      'Language',
      'Member',
      'Membership',
      'Status',
      'Reserved Date',
      'No of Days',
      'Count'
     ]]
  end

  def rows
    reservations.map do |reservation|
      [reservation.id,
       reservation.item.name,
       reservation.item.category.name,
       reservation.item.kind.titleize,
       reservation.item.language.titleize,
       reservation.member.name,
       reservation.member.membership.name,
       reservation.status.titleize,
       reservation.reserved_date,
       (Date.today - reservation.reserved_date).to_i,
       1
      ]
    end
  end
end
