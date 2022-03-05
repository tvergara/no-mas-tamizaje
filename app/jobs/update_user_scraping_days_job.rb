class UpdateUserScrapingDaysJob < ApplicationJob
  def perform(user, weekdays)
    user.scraping_days.destroy_all

    weekdays.each do |day|
      UserScrapingDay.create!(user: user, weekday: day)
    end
  end
end
