class MembershipsDatatable < GenericDatatable
  private

  def data
    records.map do |membership|
      [membership.id,
       membership.code,
       membership.name,
       membership.kind.titleize,
       action_links(membership)
      ]
    end
  end

  def records
    @memberships ||= Membership.all
    memberships = @memberships.order("#{sort_column} #{sort_direction}")
    memberships = memberships.page(page).per(per)
    if params[:search][:value].present?
      memberships = memberships.where("memberships.code ilike :search or memberships.name ilike :search or memberships.kind ilike :search", search: "%#{params[:search][:value]}%")
    end
    memberships
  end

  def columns
    %w(memberships.id memberships.code memberships.name memberships.kind)
  end
end
