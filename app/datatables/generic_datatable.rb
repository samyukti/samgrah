class GenericDatatable
  delegate :params, :url_for, :can?, to: :@view

  def initialize(view, records)
    @view = view
    @records = records
  end

  def as_json(options = {})
    {
      draw: params[:draw].to_i,
      recordsFiltered: records.total_count,
      recordsTotal: records.total_count,
      data: data
    }
  end

  private

  def data
  end

  def records
  end

  def columns
    %w()
  end

  def page
    params[:start].to_i / per + 1
  end

  def per
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns[params[:order][:column].to_i]
  end

  def sort_direction
    params[:order][:dir] == "desc" ? "desc" : "asc"
  end

  def action_links(object)
    { show: can?(:read, object) ? url_for(object) : nil,
      edit: can?(:update, object) ? url_for([:edit, object]) : nil }
  end
end
