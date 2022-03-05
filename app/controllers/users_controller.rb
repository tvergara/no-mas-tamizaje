class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
    @current_scraping_days = current_user.scraping_days.map(&:weekday)
  end

  def update
    current_user.update!(permitted_params)
    UpdateUserScrapingDaysJob.perform_now(current_user, weekdays_params.keys)
    redirect_to user_path
  end
  
  private

  def permitted_params
    params.require(:user)
          .permit(:uc_password, :rut, :phone_number, :campus_place,
                  :active, :uc_member_type, :campus)
  end

  def weekdays_params
    params.permit(UserScrapingDay.weekdays.keys)
  end
end
