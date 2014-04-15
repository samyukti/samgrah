class SearchController < ApplicationController
  authorize_resource class: false

  def results
    if params[:s].present?
      search = "%#{params[:s].gsub(/\s+/, '%')}%"
      @items = Item.where('name ilike :search', search: search)
      @creators = Creator.includes(item_creators: :item).where('sort_name ilike :search', search: search)
    end
  end

  private

  def search_params
    params.require(:search).permit(:s)
  end
end
