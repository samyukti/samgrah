class ItemsController < MastersController
private

  def item_params
    master_params
  end

  def master_params
    params.require(:item).permit(:category_id, :code, :name, :creator_id, :subject, :kind, :format, :pages, :publisher, :published_date, :language, :isbn_10, :isbn_13, :rights, :tags, :excerpt, :rating, :notes, :created_by, :updated_by)
  end
end
