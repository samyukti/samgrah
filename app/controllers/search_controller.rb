class SearchController < ApplicationController
  authorize_resource class: false

  def results
    if params[:s].present?
      search = "%#{params[:s].gsub(/\s+/, '%')}%"
      @items = Item.where('name like :search', search: search)
      @creators = Creator.includes(:items).where('sort_name like :search', search: search)
    else
      redirect_to root_url
    end
  end

private

  def search_params
    params.require(:search).permit(:s)
  end
end
