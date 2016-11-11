class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  #ActiveRecordのコールバックメソッド(ある特定の時点で呼び出されるメソッド)の一つ。
  #このコールバックメソッドは、全ての作業の最初に呼び出されるもの。
  #今回のselfは、現在のユーザを表す。
  #[self.email = self.email.downcaseの省略]
  
  before_create :create_activation_digest

  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

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
    

    #渡されたトークンがダイジェストと一致したらtrueを返す。
    # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end#このremembertokenはremember_tokenとは違って、ユーザ関数内の変数。
      #もし大局的な変数remember_tokenを使用したいなら、selfを使用する。
  

  def forget #ユーザログインを破壊する。
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated ,true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_mail
    UserMailer.account_activation(self).deliver_now
    # このメソッドのチェーンで有効化メールを送信してくれる。
  end



private

    def downcase_email  #このファイル内でbefore_saveにて使用。
      self.email = self.email.downcase  
    end

    def create_activation_digest #有効化用のトークン作成し、それのダイジェストも作成する。
     self.activation_token = User.new_token
     self.activation_digest = User.digest(activation_token)
    end

end