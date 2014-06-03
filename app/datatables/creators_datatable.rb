class CreatorsDatatable < GenericDatatable
  private

  def data
    records.map do |creator|
      [creator.id,
       creator.kind.titleize,
       creator.full_name || [creator.first_name, creator.last_name].join(' '),
       creator.sort_name,
       action_links(creator)
      ]
    end
  end

  def records
    @creators ||= Creator.all
    creators = @creators.order("#{sort_column} #{sort_direction}")
    creators = creators.page(page).per(per)
    if params[:search][:value].present?
      creators = creators.where("creators.kind ilike :search or creators.sort_name ilike :search", search: "%#{params[:search][:value]}%")
    end
    creators
  end

  def columns
    %w(creators.id creators.kind creators.full_name creator.sort_name)
  end
end
