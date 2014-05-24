class ItemsDatatable < GenericDatatable
  private

  def data
    records.map do |item|
      [item.id,
       item.code,
       item.name,
       item.category.name,
       item.kind.titleize,
       item.format.titleize,
       action_links(item)
      ]
    end
  end

  def records
    @items ||= Item.all.includes(:category)
    items = @items.order("#{sort_column} #{sort_direction}")
    items = items.page(page).per(per)
    if params[:search][:value].present?
      items = items.where("items.code ilike :search or items.name ilike :search or categories.name ilike :search", search: "%#{params[:search][:value]}%")
                   .references(:category)
    end
    items
  end

  def columns
    %w(items.id items.code items.name items.category items.kind items.format)
  end
end
