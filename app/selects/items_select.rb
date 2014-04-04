class ItemsSelect
  delegate :params, :h, :link_to, :raw, to: :@view

  def initialize(view, items)
    @view = view
    @items = items
  end

  def as_json(options = {})
    { options: data }
  end

private

  def data
    items.map do |item|
      { id: item.id,
        code: item.code,
        name: item.name,
        detail: item.creator.name,
        image: item.photo.select.url
      }
    end
  end

  def items
    items = Item.includes(:category).order("items.name")
    items = items.where("items.name ilike :search or items.code ilike :search", search: "%#{params[:s]}%") if params[:s].present?
    items = items.where(id: "#{params[:id]}") if params[:id].present?
    items.limit(params[:per] || 10)
  end
end
