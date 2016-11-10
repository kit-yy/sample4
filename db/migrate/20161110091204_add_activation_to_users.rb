class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false
    # デフォルトの論理値を決めておく用に変更。
    add_column :users, :activated_at, :datetime
  end
end