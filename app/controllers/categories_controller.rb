class CategoriesController < MastersController
  def table
    @categories = Category.all
    respond_to do |format|
      format.json { render json: CategoriesDatatable.new(view_context, @categories) }
    end
  end

  private

  def category_params
    params.require(:category).permit(:parent_id, :code, :name, :kind, :notes)
  end
end
