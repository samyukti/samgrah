class MembershipsController < MastersController
private

  def membership_params
    params.require(:membership).permit(:code, :name, :kind, :notes, :created_by, :updated_by)
  end
end
