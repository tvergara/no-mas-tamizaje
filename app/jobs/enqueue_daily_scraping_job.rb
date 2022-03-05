class EnqueueDailyScrapingJob < ApplicationJob
  def perform
    User.scrapes_today.each do |user|
      ScrapeScreeningFormJob.perform_later(user.id)
    end
  end
end
