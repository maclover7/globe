class InviteCodesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_site_admin
  before_action :set_invite_code, only: [:show, :edit, :update, :destroy]

  # GET /invite_codes
  def index
    @invite_codes = InviteCode.all
  end

  # GET /invite_codes/1
  def show
  end

  # GET /invite_codes/new
  def new
    @invite_code = InviteCode.new
  end

  # GET /invite_codes/1/edit
  def edit
  end

  # POST /invite_codes
  def create
    @invite_code = InviteCode.new(invite_code_params)

    if @invite_code.save
      redirect_to @invite_code, notice: 'Invite code was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /invite_codes/1
  def update
    if @invite_code.update(invite_code_params)
      redirect_to @invite_code, notice: 'Invite code was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /invite_codes/1
  def destroy
    @invite_code.destroy
    redirect_to invite_codes_url, notice: 'Invite code was successfully destroyed.'
  end

  private
    def authenticate_site_admin
      redirect_to root_path, notice: 'Unauthorized.' unless current_user.school_admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_invite_code
      @invite_code = InviteCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_code_params
      params.require(:invite_code).permit(:code)
    end
end
