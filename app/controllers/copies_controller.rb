class CopiesController < MastersController
private

  def copy_params
    params.require(:copy).permit(:item_id, :name, :procured_date, :quality, :quantity, :issuable, :status, :photo, :remote_photo_url, :notes)
  end
end
