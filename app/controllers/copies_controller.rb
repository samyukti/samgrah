class CopiesController < MastersController
  def select
    @masters = Copy.where(id: "#{params[:id]}") if params[:id].present?
    respond_to do |format|
      format.json { render json: CopiesSelect.new(@masters, params) }
    end
  end

  private

  def copy_params
    params.require(:copy).permit(:item_id, :name, :procured_date, :format, :length, :length_uom,
                                 :publisher, :published_date, :quality, :quantity, :cost, :price,
                                 :issuable, :status, :location, :photo, :remote_photo_url, :notes)
  end
end
