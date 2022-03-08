class AddLogsToIntents < ActiveRecord::Migration[6.1]
  def change
    add_column :fill_screening_form_intents, :logs, :text, array: true, default: []
  end
end
