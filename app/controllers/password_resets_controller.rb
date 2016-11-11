class PasswordResetsController < ApplicationController
  def new
  end

  def edit
  end


# sessionコントローラのcreateアクションをパクる。
# 最初とifでの分け方程度しか使えないことに注意。
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    # ここでユーザが入力したemailを探してそのユーザを@uerとする。
    if @user#そのユーザが存在したら、@userはtrue。
      @user.create_reset_digest
      @user.send_reset_email
      flash[:info] = "Email sent with password reset instruction"
      redirect_to root_path
    else
      flash[:info] = "Email is not exist"
      render 'new'
    end
  end
end
