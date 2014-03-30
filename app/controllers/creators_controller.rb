class CreatorsController < MastersController
private

  def master_params
    params.require(:creator).permit(:kind, :name, :first_name, :middle_name, :last_name, :sort_name, :notes, :created_by, :updated_by)
  end
end
