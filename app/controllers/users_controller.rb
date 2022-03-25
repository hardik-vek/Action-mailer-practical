class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_later
      flash[:notice] = "user successfully created"
      redirect_to users_path
    else
      flash[:alert] = "something wrong happend"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user successfully edited"
      redirect_to users_path
    else
      flash[:alert] = "something wrong happend"
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :picture)
  end
end
