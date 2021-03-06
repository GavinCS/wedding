class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_body_class
  helper_method :current_admin_user
  helper_method :current_guest_user

  def confirm_admin_logged_in
    unless session[:user_id]
      self::store_location
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'admin', :action => 'sign_in')
      return false # halts the before_filter
    else
      unless session[:last_seen] > 100.minutes.ago
        reset_session
        self::store_location
        flash[:notice] = "session expired please log in."
        redirect_to(:controller => 'admin', :action => 'sign_in')
        return false # halts the before_filter
      else
        @userAuthenticated  = User.find(session[:user_id])
        session[:last_seen] = Time.now
        return true
      end
    end
  end


  def current_admin_user
    unless session[:user_id]
      return false
    else
      @userAuthenticated  = User.find(session[:user_id])
      return true
    end
  end

  def confirm_guest_logged_in
    unless session[:guest_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'guests', :action => 'sign_in')
      return false # halts the before_filter
    else
      unless session[:guest_last_seen] > 100.minutes.ago
        reset_session
        flash[:notice] = "session expired please log in."
        redirect_to(:controller => 'guests', :action => 'sign_in')
        return false # halts the before_filter
      else
        @guestAuthenticated  = Guest.find(session[:guest_id])
        session[:guest_last_seen] = Time.now
        return true
      end
    end
  end

  def current_guest_user
    unless session[:guest_id]
      return false
    else
      @guestAuthenticated  = Guest.find(session[:guest_id])
      return true
    end
  end

  def set_body_class
    @bodyClass = ''
    if self.class.parent == Admin
      @bodyClass = 'admin-body'
    end
  end

  def store_location
    !request.env["HTTP_REFERER"].blank? and  request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
    session[:return_to] =  request.env["HTTP_REFERER"]
    else
      session[:return_to] =  request.env["REQUEST_URI"]
  end
end
