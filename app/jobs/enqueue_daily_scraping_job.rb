class EnqueueDailyScrapingJob < ApplicationJob
  def perform
    User.active.scrapes_today.each do |user|
      ScrapeScreeningFormJob.perform_later(user.id)
    end
  end
end
