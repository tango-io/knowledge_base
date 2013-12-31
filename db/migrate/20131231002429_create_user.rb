class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image
      t.string :token
      t.string :token_refresh_token
      t.integer :token_expires_at
    end

    add_index :users, :uid
  end
end
