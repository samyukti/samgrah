class CopiesDatatable < GenericDatatable
  private

  def data
    records.map do |copy|
      [copy.id,
       copy.item.name,
       copy.name,
       copy.quality.titleize,
       copy.status.titleize,
       copy.issued,
       action_links(copy)
      ]
    end
  end

  def records
    @copies ||= Copy.all.includes(:item)
    copies = @copies.order("#{sort_column} #{sort_direction}")
    copies = copies.page(page).per(per)
    if params[:search][:value].present?
      copies = copies.where("items.name ilike :search or copies.name ilike :search or copies.status ilike :search", search: "%#{params[:search][:value]}%")
                   .references(:item)
    end
    copies
  end

  def columns
    %w(copies.id copies.item copies.name copies.quality copies.status copies.issued)
  end
end
