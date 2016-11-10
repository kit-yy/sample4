class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    # デフォルトの論理値を決めておく用に変更。
  end
end