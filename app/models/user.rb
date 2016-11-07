class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
    #ActiveRecordのコールバックメソッド(ある特定の時点で呼び出されるメソッド)の一つ。
  #このコールバックメソッドは、全ての作業の最初に呼び出されるもの。
  #今回のselfは、現在のユーザを表す。
  #[self.email = self.email.downcaseの省略]
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 与えられた文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
   # digestの計算は、ユーザ毎に行われるため、user.rbに配置。


  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
    #ランダムなトークンを返すメソッド。
  #パスワードではなく、cookies版のdigestメソッドのようなもの。
  #ということで、同様にuser.rbで定義。

  # 永続的セッションで使用するユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
    # クラス利用のselfではなく、インスタンス利用のself。
    #このselfはこの関数が含まれている「Userクラス」のインスタンスに置き換えられる
    #こう定義しないと、Rubyが勝手にremember_tokenというローカル変数を作ってしまう。
    

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
     #このremembertokenはremember_tokenとは違って、ユーザ関数内の変数。
    #もし大局的な変数remember_tokenを使用したいなら、selfを使用する。
  

  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end