class CopiesController < MastersController
private

  def copy_params
    master_params
  end

  def master_params
    params.require(:copy).permit(:item_id, :name, :procured_date, :quality, :quantity, :issuable, :status, :notes)
  end
end
