class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email, null: false
      t.string :encrypted_password, null: false, default: ""
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
