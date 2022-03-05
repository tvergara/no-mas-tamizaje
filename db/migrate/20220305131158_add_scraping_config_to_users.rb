class AddScrapingConfigToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uc_password, :string 
    add_column :users, :rut, :string 
    add_column :users, :name, :string 
    add_column :users, :phone_number, :string 
    add_column :users, :uc_member_type, :integer 
    add_column :users, :campus, :integer 
    add_column :users, :campus_place, :string 
    add_column :users, :active, :boolean
  end
end
