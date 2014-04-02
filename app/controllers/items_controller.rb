class ItemsController < MastersController
private

  def item_params
    params.require(:item).permit(:category_id, :code, :name, :creator_id, :subject, :kind,
                                 :format, :length, :length_uom, :publisher, :published_date,
                                 :language, :isbn_10, :isbn_13, :rights, :tags, :excerpt,
                                 :rating, :photo, :remote_photo_url, :notes)
  end
end
