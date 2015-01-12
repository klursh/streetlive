class UsersController < ApplicationController
  load_and_authorize_resource
  
  def show
  end

  def new
    auth = session["devise.google_data"]
    return redirect_to root_url unless auth
    @user.attributes = { name:  auth.info.name,
                         email: auth.info.email }
  end

  def create
    auth = session["devise.google_data"]
    return redirect_to root_url unless auth
    @user.attributes = {
      google_uid:           auth.uid,
      google_token:         auth.credentials.token,
      google_refresh_token: auth.credentials.refresh_token,
      expires_at:           auth.credentials.expires_at,
      image:                auth.info.image[0, auth.info.image.rindex("?")]
    }
    if @user.save
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect @user, event: :authentication
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = I18n.t "helpers.notices.updated", model: User.model_name.human
      redirect_to user_url(@user)
    else
      render "edit"
    end
  end

  def destroy
    current_user.artist.try(:destroy)
    current_user.scout.try(:destroy)
    current_user.destroy
    flash[:notice] = I18n.t "helpers.notices.destroyed", model: User.model_name.human
    redirect_to root_url
  end

  # NOTICE: DO NOT rename this method to sign_out.
  #   sign_out_and_redirect calls UsersController#sign_out so
  #   it raises SystemStackError.
  def logout
    sign_out_and_redirect current_user
    flash[:notice] = I18n.t "devise.sessions.signed_out"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :introduction)
    end
end
