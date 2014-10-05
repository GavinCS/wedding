class Admin::AdminController < ApplicationController
  layout "login_layout", :only => [:sign_in]
  before_filter :confirm_admin_logged_in, :except => [:sign_in]
  def index
    @users = User.all
    @user = User.new
  end

  def sign_in
    if current_admin_user
      redirect_to users_index_path
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    params[:user][:password] = 'gavin1987' #User.generate_secure_password
    @users = User.all
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        BlairMailer.new_user_invite(@user, params[:user][:password]).deliver
        format.html { redirect_to :action => 'index', notice: 'User was successfully created.' }
      else
        format.html { render action: 'index' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @password = params[:user][:password]
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        unless @password.blank?
          BlairMailer.user_update(@user, @password).deliver
        end

        format.html { redirect_to :action => 'index', notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit', :notice => 'error saving' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path , notice: 'User was successfully destroyed'}
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :password ,:admin ,:password_confirmation)
  end
end
