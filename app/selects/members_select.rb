class MembersSelect
  def initialize(members, params = {})
    @members = members
    @params = params
  end

  def as_json(options = {})
    data
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

  def search_members
    members = Member.includes(:membership).order("members.name")
    members = members.where("members.name ilike :search or members.code ilike :search", search: "%#{@params[:s]}%") \
      if @params[:s].present?
    members.limit(@params[:per] || 10)
  end

  def members
    @members || search_members
  end
end
