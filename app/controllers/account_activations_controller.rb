
# アカウントの有効化に置けるやり取りには、RESTのurlを使用する。
# その為にコントローラを新規作成。

class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
        user.activate #user.rbに定義したメソッド。
        log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end