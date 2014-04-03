class MembersSelect
  delegate :params, :h, :link_to, :raw, to: :@view

  def initialize(view, members)
    @view = view
    @members = members
  end

  def as_json(options = {})
    { options: data }
  end

private

  def data
    members.map do |member|
      { id: member.id,
        code: member.code,
        name: member.name,
        detail: member.membership.name,
        image: "/members/#{member.id}/photo/select"
      }
    end
  end

  def members
    members = Member.includes(:membership).order("members.name")
    members = members.where("members.name ilike :search or members.code ilike :search", search: "%#{params[:s]}%") if params[:s].present?
    members = members.where(id: "#{params[:id]}") if params[:id].present?
    members.limit(params[:per])
  end
end
