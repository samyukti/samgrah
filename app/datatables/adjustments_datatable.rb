class AdjustmentsDatatable < GenericDatatable
  private

  def data
    records.map do |adjustment|
      [adjustment.id,
       adjustment.copy.name,
       adjustment.item.name,
       adjustment.adjusted_date,
       adjustment.status.titleize,
       action_links(adjustment)
      ]
    end
  end

  def records
    @adjustments ||= Adjustment.all.includes(:copy, :item)
    adjustments = @adjustments.order("#{sort_column} #{sort_direction}")
    adjustments = adjustments.page(page).per(per)
    if params[:search][:value].present?
      adjustments = adjustments.where("copies.name ilike :search or items.name ilike :search", search: "%#{params[:search][:value]}%")
                   .references(:copy, :item)
    end
    adjustments
  end

  def columns
    %w(adjustments.id adjustments.copy_id adjustments.item_id adjustments.adjusted_date adjustments.status)
  end
end
