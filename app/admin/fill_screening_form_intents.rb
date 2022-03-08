ActiveAdmin.register FillScreeningFormIntent do
  includes :user

  index do
    id_column
    column :user_email do |intent|
      intent.user.email
    end
    column :state
    column :error_category
    column :created_at
  end

  action_item only: :index do
    link_to 'Enqueue Daily Intents', enqueue_daily_intents_admin_fill_screening_form_intents_path, method: :post
  end

  collection_action :enqueue_daily_intents, method: :post do
    EnqueueDailyScrapingJob.perform_later
    redirect_to collection_path, notice: 'Daily intents enqueued'
  end
end
