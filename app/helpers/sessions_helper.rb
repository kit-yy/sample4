module SessionsHelper
    # sessionを実装するにはたくさんのコントローラやビューで定義する必要があるが、これなら一度ですむ


    def log_in(user)
        session[:user_id] = user.id
    end
        #ユーザのブラウザ内の一時cookieにユーザidが登録される。（暗号化されて） 

    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
