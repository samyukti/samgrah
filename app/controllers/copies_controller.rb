class CopiesController < MastersController
  def select
    respond_to do |format|
      format.json { render json: CopiesSelect.new(view_context, @masters) }
    end
  end

private

  def copy_params
    params.require(:copy).permit(:item_id, :name, :procured_date, :quality, :quantity,
                                 :issuable, :status, :location, :photo, :remote_photo_url, :notes)
  end
end
