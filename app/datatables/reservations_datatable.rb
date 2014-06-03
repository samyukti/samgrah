class ReservationsDatatable < GenericDatatable
  private

  def data
    records.map do |reservation|
      [reservation.id,
       reservation.item.name,
       reservation.member.name,
       reservation.reserved_date,
       reservation.status.titleize,
       action_links(reservation)
      ]
    end
  end

  def records
    @reservations ||= Reservation.all.includes(:item, :member)
    reservations = @reservations.order("#{sort_column} #{sort_direction}")
    reservations = reservations.page(page).per(per)
    if params[:search][:value].present?
      reservations = reservations.where("items.name ilike :search or members.name ilike :search", search: "%#{params[:search][:value]}%")
                   .references(:item, :member)
    end
    reservations
  end

  def columns
    %w(reservations.id reservations.item reservations.member reservations.reserved_date reservations.status)
  end
end
