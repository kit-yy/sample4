class ApplicationMailer < ActionMailer::Base
  default from: "noreply@example.com"
  #デフォルトのfromメールアドレス #各メソッド(user_mailer.rb)に宛先メールアドレスがある。
  layout 'mailer'
end


