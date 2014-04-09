class ItemsController < MastersController
  def new
    @master = @master_class.new
    @master.item_creators.build
  end

  def copy
    original = @master
    @master  = @master_class.new(original.attributes)

    original.item_creators.each do |creator|
      @master.item_creators.build(creator.attributes)
    end

    render :new
  end

  def edit
    @master.item_creators.build unless @master.item_creators.present?
  end

  def select
    @masters = Item.where(id: "#{params[:id]}") if params[:id].present?
    respond_to do |format|
      format.json { render json: ItemsSelect.new(@masters, params) }
    end
  end

private

  def item_params
    params.require(:item).permit(:category_id, :code, :name, :subject, :kind, :format, :length, :length_uom,
                                 :publisher, :published_date, :language, :isbn_10, :isbn_13, :rights,
                                 :tags, :excerpt, :rating, :photo, :remote_photo_url, :notes,
                                 item_creators_attributes: [:id, :sequence, :creator_id, :role, :_destroy])
  end
end
