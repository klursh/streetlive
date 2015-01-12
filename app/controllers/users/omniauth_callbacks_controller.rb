class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    # excep(:extra) to avoid ActionDispatch::Cookies::CookieOverflow
    # see: http://stackoverflow.com/questions/7117200/devise-for-twitter-cookie-overflow-error
    auth = request.env["omniauth.auth"].except(:extra)
    @user = User.find_for_google_oauth2(auth)
    if @user
      @user.update(google_token:         auth.credentials.token,
                   google_refresh_token: auth.credentials.refresh_token,
                   expires_at:           auth.credentials.expires_at)
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = auth
      redirect_to new_user_url
    end
  end

end
