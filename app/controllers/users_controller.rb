class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the sample app!"
      sign_in @user   #signs in user after s/he signs up for an account
      redirect_to user_path(@user) #user_path(@user) can be rewritten to just @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

end
