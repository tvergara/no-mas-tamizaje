class CreateUserScrapingDays < ActiveRecord::Migration[6.1]
  def change
    create_table :user_scraping_days do |t|
      t.integer :weekday, null: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
