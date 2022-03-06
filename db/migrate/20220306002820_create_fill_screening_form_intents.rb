class CreateFillScreeningFormIntents < ActiveRecord::Migration[6.1]
  def change
    create_table :fill_screening_form_intents do |t|
      t.references :user, null: false
      t.string :state
      t.integer :error_category
      t.string :error_detail

      t.timestamps
    end
  end
end
