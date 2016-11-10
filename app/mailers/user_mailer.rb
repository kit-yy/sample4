class UserMailer < ApplicationMailer




    #新規登録の際にアカウントを有効化する為に使うメール。
    #ここで使用する引数となるuserが欲しい。
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end







  def password_reset #パスワード忘れた人が、パスワードリセット用に使うメール。
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
