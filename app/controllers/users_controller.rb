class UsersController < ApplicationController

  before_action     :require_signin,        except: [:new, :create]
  before_action     :require_correct_user,  only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @page_title = 'All users'
  end

  def show
    @user = User.find(params[:id])
    @page_title = @user.name
  end

  def new
    @user = User.new
    render layout: 'session'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      session[:user_id] = @user.id
      redirect_to @user, success: 'Thanks for signing up!'
    else
      render :new, layout: 'session'
    end
  end

  def edit
    @page_title = "Editing #{@user.name}"
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: 'Account successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, info: 'Account successfully deleted.'
  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
