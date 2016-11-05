class AddRememberDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remembe_digest, :string
  end
end
