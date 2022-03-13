class EncryptUcPasswords < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uc_password_ciphertext, :text

    Lockbox.migrate(User)
  end
end
