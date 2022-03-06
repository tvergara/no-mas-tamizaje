class FillScreeningFormIntent < ApplicationRecord
  include AASM
  belongs_to :user
  enum error_category: ['unknown', 'invalid_credentials']

  aasm column: :state do
    state :created, initial: true
    state :failed, :succeeded

    event :fail do
      transitions from: :created, to: :failed
    end
    event :succeed do 
      transitions from: :created, to: :succeeded
    end
  end
end

# == Schema Information
#
# Table name: fill_screening_form_intents
#
#  id             :bigint(8)        not null, primary key
#  user_id        :bigint(8)        not null
#  state          :string
#  error_category :integer
#  error_detail   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_fill_screening_form_intents_on_user_id  (user_id)
#
