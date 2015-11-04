class Api::RegistrationsController < ApiController
  respond_to :json

  def create
    type = user_params['type']
    user = type.constantize.new(user_params)
    if user.save
      render :json => user.as_json(:auth_token => user.authentication_token, :email => user.email),
        :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors, :status => 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :type, :email, :password, :password_confirmation, :current_password)
  end
end
