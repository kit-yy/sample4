class RemoveRemembeDigestFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :remembe_digest, :string
  end
end
