class MembershipsController < MastersController
  def table
    @memberships = Membership.all
    respond_to do |format|
      format.json { render json: MembershipsDatatable.new(view_context, @memberships) }
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:code, :name, :kind, :notes)
  end
end
