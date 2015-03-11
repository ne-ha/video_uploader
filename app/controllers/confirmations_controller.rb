class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    @user = User.find_by_confirmation_token(params[:confirmation_token])
  end

  def confirm
    @user = User.find_by_confirmation_token(params[:user][:confirmation_token])
    if @user.update_attributes(params[:user]) and @user.password_match?
      @user = User.confirm_by_token(@user.confirmation_token)
      set_flash_message :notice, :confirmed
      sign_in_and_redirect("user", @user)
    else
      render :show
    end
  end

end
