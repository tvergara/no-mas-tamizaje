class EnqueueDailyScrapingJob < ApplicationJob
  WAITING_SECONDS = ENV.fetch('SCRAPE_WAITING_SECONDS', 10).to_i

  def perform
    current_wait = 0
    User.active.scrapes_today.each do |user|
      ScrapeScreeningFormJob.set(wait: current_wait.seconds).perform_later(user.id)
      current_wait += WAITING_SECONDS
    end
  end
end
