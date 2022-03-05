class UserScrapingDay < ApplicationRecord
  belongs_to :user
  enum weekday: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado']
end

# == Schema Information
#
# Table name: user_scraping_days
#
#  id         :bigint(8)        not null, primary key
#  weekday    :integer          not null
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_scraping_days_on_user_id  (user_id)
#
