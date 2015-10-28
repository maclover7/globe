class RegistrationsController < Devise::RegistrationsController
  def create
    if resource_name == :teacher
      @invite_code = params['teacher']['invite_code']
      if @invite_code.nil? or !InviteCode.where(code: @invite_code).any?
        redirect_to root_path, notice: 'Unauthorized'
      else
        params['teacher'].delete('invite_code')
        super
      end
    else
      super
    end
  end

  def new
    if resource_name == :teacher
      @invite_code = params[:invite_code]
      if params[:invite_code].nil? or !InviteCode.where(code: @invite_code).any?
        redirect_to root_path, notice: 'Unauthorized'
      else
        super
      end
    else
      super
    end
  end

  def sign_up(resource_name, resource)
    sign_in(:user, resource)
  end
end
