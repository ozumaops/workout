class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end

  def sns_create
    if request.env['omniauth.auth'].present?
      # Googleログイン
      @user  = User.from_omniauth(request.env['omniauth.auth'])
      result = @user.save(context: :google_create)
      gg       = "google"
    end
    if result
      log_in @user
      flash[:success] = "#{gg}アカウントでログインしました。" 
      redirect_back_or user_days_url(@user)
    else
      if gg.present?
        flash[:danger] = "ログイン出来ませんでした" 
        redirect_to auth_failure_path
      else
        render 'new'
      end
    end
  end

  def destroy
     # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end