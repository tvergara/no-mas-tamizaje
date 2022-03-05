class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    current_user.update!(permitted_params)
    redirect_to user_path
  end
  
  private

  def permitted_params
    params.require(:user)
          .permit(:uc_password, :rut, :phone_number, :campus_place,
                  :active, :uc_member_type, :campus)
  end
end
