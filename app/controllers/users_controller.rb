class UsersController < MastersController
  before_filter :authenticate_user!

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    updated = if needs_password?(@user, master_params)
                @user.update(master_params)
              else
                @user.update_without_password(master_params)
              end

    respond_to do |format|
      if updated
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_ids)
  end

  def needs_password?(user, params)
    params[:password].present?
  end
end
