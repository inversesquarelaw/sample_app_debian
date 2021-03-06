class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
    @users = User.paginate(:page => params[:page])
    @title = "All users"
  end

  def edit
    @title = "Edit user"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
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
      redirect_to @user #user_path(@user) can be rewritten to just @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => {:success => "Profile updated."}
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :flash => {:success => "User destroyed."}
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if (!current_user.admin? || current_user?(@user))
    end

end #all
