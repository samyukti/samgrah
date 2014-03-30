class UsersController < MastersController
private

  def master_params
    params[:user]
  end
end
