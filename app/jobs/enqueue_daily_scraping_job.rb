class EnqueueDailyScrapingJob < ApplicationJob
  def perfom
    User.scrapes_today.each do |user|
      ScrapeScreeningFormJob.perform_later(user.id)
    end
  end
end
