class CreatorsController < MastersController
private

  def creator_params
    params.require(:creator).permit(:kind, :name, :first_name, :middle_name, :last_name, :full_name, :sort_name, :notes)
  end
end
