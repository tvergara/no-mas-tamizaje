class DropPlainTextUcPassword < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :users, :uc_password }
  end
end
