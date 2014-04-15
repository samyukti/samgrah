class ItemsSelect
  def initialize(items, params = {})
    @items = items
    @params = params
  end

  def as_json(options = {})
    data
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

  def search_items
    items = Item.order("items.name")
    items = items.where("items.name ilike :search or items.code ilike :search", search: "%#{@params[:s]}%") \
      if @params[:s].present?
    items.limit(@params[:per] || 10)
  end

  def items
    @items || search_items
  end
end
