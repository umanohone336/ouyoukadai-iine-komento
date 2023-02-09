class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    user_path(resource)
  end
# after_sign_in_path_forはsign_in後のリダイレクト先を指定するメソッドになります。
# 本来はsign_in後、ログインしたuserの詳細ページに飛ぶような設定にするはずです。
# しかしapplication_controllerを確認してみると、root_pathに設定されているためにtopページが表示されてしまう状態になっています。
# ですので適切なpathに変更してあげましょう
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
# before_action :authenticate_user!は、deviseを入れると使えるようになるヘルパーメソッドであり、
#コントローラーに設定することで、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。
#controller/application_controller.rbに書いてしまうと、
#全コントローラに適用されてしまい、ログインが関係ないところにも実行されてしまうため、
#制限が必要ない、トップページ・アバウトページにもかかってしまいます。
#bookとuserのcontrollerだけに、before_action :authenticate_user!を追記してあげましょう。