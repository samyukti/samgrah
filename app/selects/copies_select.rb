class CopiesSelect
  def initialize(copies, params = {})
    @copies = copies
    @params = params
  end

  def as_json(options = {})
    data
  end

  private

  def data
    copies.map do |copy|
      { id: copy.id,
        code: copy.item.name,
        name: copy.name,
        detail: copy.item.creator ? copy.item.creator.name : '',
        image: copy.image_url(:select)
      }
    end
  end

  def search_copies
    copies = Copy.available.includes(item: :category).order("copies.name")
    copies = copies.where("copies.name ilike :search or items.name ilike :search", search: "%#{@params[:s]}%")
                   .references(:items) if copies.present? && @params[:s].present?
    copies.limit(@params[:per] || 10)
  end

  def copies
    @copies || search_copies
  end
end
