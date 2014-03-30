class CategoriesController < MastersController
private

  def master_params
    params.require(:category).permit(:parent_id, :code, :name, :kind, :notes, :created_by, :updated_by)
  end
end
