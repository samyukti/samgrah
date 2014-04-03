class CopiesSelect
  delegate :params, :h, :link_to, :raw, to: :@view

  def initialize(view, copies)
    @view = view
    @copies = copies
  end

  def as_json(options = {})
    { options: data }
  end

private

  def data
    copies.map do |copy|
      { id: copy.id,
        code: copy.name,
        name: copy.item.name,
        detail: copy.item.creator.name,
        image: copy.image_url(:select)
      }
    end
  end

  def copies
    copies = Copy.includes(item: :category).order("copies.name")
    if params[:id].present?
      copies = copies.where(id: "#{params[:id]}")
    else
      copies = copies.available
    end
    copies = copies.where("copies.name ilike :search or items.name ilike :search", search: "%#{params[:s]}%") \
      if params[:s].present?
    copies.limit(params[:per])
  end
end
