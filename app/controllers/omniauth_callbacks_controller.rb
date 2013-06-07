class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def omniauth_callback
    auth = request.env['omniauth.auth']
    authentication =  Authentication.where(provider: auth.prodiver, uid: auth.uid).first
    if authentication
      @user = authentication.user
    else
      @user = Account.where(email: auth.info.email).first
      if @user
        @user.authentication.create(provider: auth.provider, uid: auth.uid,
         token: auth.credentials[:token], secret: auth.credentials[:secret])
      else
        @user= Account.create(email: auth.info.email, password: Devise.friendly_token[0,20])
        @user.authentication.create(provider: auth.provider, uid: auth.uid,
         token: auth.credentials[:token], secret: auth.credentials[:secret])
      end
    end
    sign_in_and_redirect @user, :event => :authentication
  end
end


  # def all
  #   user = User.from_omniauth(request.env["omniauth.auth"])
  #   if user.persisted?
  #     flash.notice = "Signed in!"
  #     sign_in_and_redirect user
  #   else
  #     session["devise.user_attributes"] = user.attributes
  #     redirect_to new_user_registration_url
  #   end
  # end
  # alias_method :facebook, :all
# end