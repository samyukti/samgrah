class ItemsController < MastersController
  def table
    @items = Item.all.includes(:category)
    respond_to do |format|
      format.json { render json: ItemsDatatable.new(view_context, @items) }
    end
  end

  def new
    @item = Item.new
    @item.item_creators.build
  end

  def copy
    original = @item
    @item    = Item.new(original.attributes)

    original.item_creators.each do |creator|
      @item.item_creators.build(creator.attributes)
    end

    render :new
  end

  def edit
    @item.item_creators.build unless @item.item_creators.present?
  end

  def select
    @items = Item.where(id: "#{params[:id]}") if params[:id].present?
    respond_to do |format|
      format.json { render json: ItemsSelect.new(@items, params) }
    end
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :code, :name, :subject, :kind, :format, :length, :length_uom,
                                 :publisher, :published_date, :language, :isbn_10, :isbn_13, :rights, :cost,
                                 :price, :tags, :excerpt, :rating, :photo, :remote_photo_url, :copywise, :notes,
                                 item_creators_attributes: [:id, :sequence, :creator_id, :role, :_destroy])
  end
end
