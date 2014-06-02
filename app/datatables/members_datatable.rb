class MembersDatatable < GenericDatatable
  private

  def data
    records.map do |member|
      [member.id,
       member.code,
       member.name,
       member.membership.name,
       member.kind.titleize,
       action_links(member)
      ]
    end
  end

  def records
    @members ||= Member.all.includes(:membership)
    members = @members.order("#{sort_column} #{sort_direction}")
    members = members.page(page).per(per)
    if params[:search][:value].present?
      members = members.where("members.code ilike :search or members.name ilike :search or memberships.name ilike :search", search: "%#{params[:search][:value]}%")
                   .references(:membership)
    end
    members
  end

  def columns
    %w(members.id members.code members.name members.membership members.kind)
  end
end
