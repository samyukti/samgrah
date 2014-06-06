class CategoriesDatatable < GenericDatatable
  private

  def data
    records.map do |category|
      [category.id,
       category.code,
       category.name,
       category.kind.titleize,
       action_links(category)
      ]
    end
  end

  def records
    @categories ||= Category.all
    categories = @categories.order("#{sort_column} #{sort_direction}")
    categories = categories.page(page).per(per)
    if params[:search][:value].present?
      categories = categories.where("categories.code ilike :search or categories.name ilike :search or categories.kind ilike :search", search: "%#{params[:search][:value]}%")
    end
    categories
  end

  def columns
    %w(categories.id categories.code categories.name categories.kind)
  end
end
