class SessionsController < ApplicationController

  def new_admin
    authorized_user = User.authenticate(params[:email], params[:password])
    if authorized_user
      session[:user_id] 	= authorized_user.id
      session[:last_seen] = Time.now()
      session[:user_name] = authorized_user.name
      flash[:notice] = "Hey there #{authorized_user.name}"
      # record_activity("Logged in")
      redirect_back_or_default('/admin/index/')
    else
      flash[:error] = "Invalid email/password combination."
      redirect_to(:controller => 'admin/admin', :action => 'sign_in')
    end
  end

  def new_guest
      authorized_user = Guest.authenticate(params[:email], params[:password])

    if authorized_user
      session[:guest_id] 	= authorized_user.id
      session[:guest_last_seen] = Time.now()
      session[:user_name] = authorized_user.name
      flash[:notice] = "Hey there #{authorized_user.name}"
      # record_activity("Logged in")
      redirect_to(guests_dashboard_path(authorized_user.id))
    else
      flash[:error] = "Invalid email/password combination."
      redirect_to(:controller => 'guests', :action => 'sign_in')
    end
  end

  def destroy_admin
    session[:user_id] = nil
    session[:username] = nil
    session[:last_seen] = nil
    flash[:notice] = "Logged Out, See you soon!"
    redirect_to(:controller => 'admin', :action => 'sign_in')
  end

  def destroy_guest
    session[:guest_id] = nil
    session[:username] = nil
    session[:guest_last_seen] = nil
    flash[:notice] = "Logged Out, See you soon!"
    redirect_to(:controller => 'guests', :action => 'sign_in')
  end
end

private


def redirect_back_or_default(default)
  redirect_to(session[:return_to] || default)
  session[:return_to] = nil
end


#def redirect_to_back(default = root_url)
#  if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
#    redirect_to :back
#  else
#    redirect_to default
#  end
#
#end