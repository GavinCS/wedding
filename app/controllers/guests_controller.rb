class GuestsController < ApplicationController
#  before_filter :confirm_admin_logged_in, :only => [:new, :index, :show]
  before_filter :confirm_guest_logged_in, :only => [:register, :rsvp]
  layout "login_layout", :only => [:sign_in]

  def rsvp
  end

  def sign_in
    if current_guest_user
        @userId = @guestAuthenticated.id
        redirect_to guests_dashboard_path(@userId)
    end
  end

  def dashboard
    if !current_guest_user
      attempt_auto_login
    else
      @user = Guest.find(params[:id])
      @kids = split_kids(@user)
      scope_guest_views(@user.id)
    end


  end

  def register
    @guest = Guest.find(params[:id])

    if GuestAddress.find_by_guest_id(params[:id])
      @address =  GuestAddress.find_by_guest_id(params[:id])
    else
      @address = GuestAddress.new
    end
  end

  def saveAddress
    @address = GuestAddress.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to root_path, :notice => 'Address saved.' }
      else
        format.html {redirect_to new_guest_lists_path, :notice => 'error.'}
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def updateAddress
    @address = GuestAddress.find_by_guest_id(params[:guest_address][:guest_id])

    respond_to do |format|
      if @address.update_attributes(address_params)
        format.html { redirect_to root_path, :notice => 'Address Updated.' }
      else
        format.html {redirect_to new_guest_lists_path, :notice => 'error.'}
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def address_params
    params.require(:guest_address).permit(
                                        :guest_id,
                                        :street_1,
                                        :street_2,
                                        :suburb,
                                        :postcode,
                                        :region,
                                        :country_id
    )
  end

  def attempt_auto_login
    authorized_user = Guest.authenticate('', '',params[:token])

    if authorized_user
      session[:guest_id] 	= authorized_user.id
      session[:guest_last_seen] = Time.now()
      session[:user_name] = authorized_user.name
      unless authorized_user.partner_name.blank?
        flash[:notice] = "Hey there #{authorized_user.name} & #{authorized_user.partner_name}"
      else
        flash[:notice] = "Hey there #{authorized_user.name}"
      end
      # record_activity("Logged in")
      if params[:address].present?
        redirect_to guests_register_path(authorized_user.id)
      elsif params[:rsvp].present?
        redirect_to guests_rsvp_path(authorized_user.id)
      end

    else
      flash[:error] = "Invalid token: please sign in"
      redirect_to(:controller => 'guests', :action => 'sign_in')
    end

  end

  def scope_guest_views(id)
    if session[:guest_id] != id && !current_admin_user
      redirect_to guests_dashboard_path(session[:guest_id])

    elsif params[:address].present?
        redirect_to guests_register_path(id)
    elsif params[:rsvp].present?
        redirect_to guests_rsvp_path(id)
    end
  end

  def split_kids(user)
    kids =''
    unless user.kids.blank?
      kids = user.kids.split('|')

    end

    return kids
  end

end
