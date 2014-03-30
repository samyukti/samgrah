class MembershipsController < MastersController
private

  def master_params
    params.require(:membership).permit(:code, :name, :kind, :notes, :created_by, :updated_by)
  end
end
