class Admin::GuestAccountsController < ApplicationController
  before_filter :confirm_admin_logged_in

  def index
    @guests = Guest.all

    # Get Rsvp Count
    model = Guest.new
    @rsvped = model.get_rsvped
    @noRsvp = model.get_no_rsvp
    @invitedGuests = @rsvped + @noRsvp

  end

  def addresses
    @addresses = GuestAddress.joins(:guest)

  end

  def show
    @guest = Guest.find(params[:id])
    @guest_address = GuestAddress.find_by_guest_id(@guest.id)
    @guest_country = Country.find(@guest_address.country_id)
    puts @guest_address
  end

  def new
    @guest = Guest.new
  end

  def create
    params[:guest][:password] =  Guest.generate_secure_password
    params[:guest][:password] = 'gavin1987'
    @guest = Guest.new(guest_params)

    respond_to do |format|
      if @guest.save
        format.html { redirect_to :action => 'index', notice: 'Guest was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit
    @guest = Guest.find(params[:id])
  end


  def update
    @guest = Guest.find(params[:id])

    respond_to do |format|
        if @guest.update_attributes(guest_params)
        format.html { redirect_to :action => 'index', notice: 'Guest was successfully updated.' }
      else
        format.html { render action: 'edit' }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    @import = Guest.import(params[:file])

    respond_to do |format|
      flash[:notice] = "Imported guests successfully"
      format.html { redirect_to :action => 'index'}
    end
  end

  def communicate
    @guests = Guest.all
    @templates = MailTemplate.all

  end

  def ajax_get_guests
     mailTemplate = params[:mail_template]
     respond_to do |format|

       @guests = Guest.select('name','email','id').where(mailTemplate + '_mail' => nil).where.not('email' => nil)
       format.json { render json: @guests }
     end
  end

  def send_email

    @validate = validate_email_paramters(params)

    if @validate[:error]

      @validate[:validationMessages].each do |message|
        flash[:notice] = message[1]
      end
      redirect_to guests_communicate_path

    else
      @guestIds = params[:guest_ids]
      @template = MailTemplate.find_by_template(params[:mail_template])
      @subject = params[:subject]

      @guestIds.each do |id|
        guest = Guest.find(id)
        GuestMailer.send_guest_mail(guest, @template, @subject).deliver
        Guest.update(id, :save_the_date_mail => true)
      end
      respond_to do |format|
        flash[:notice] = "#{@template.name} successfully sent to #{@guestIds.count} guests"
        format.html { redirect_to :action => 'communicate'}
      end
    end
  end

  def new_address
    @address = GuestAddress.new
    @guests = Guest.includes(:guest_address).where(guest_addresses: { id: nil })
  end

  def create_address
    @address = GuestAddress.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to new_address_path, :notice => 'Address saved.' }
      else
        format.html {redirect_to new_address_path, :notice => 'error.'}
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_address
    @address = GuestAddress.find_by(params[:id])
    @guest = @address.guest
  end

  def update_address
    @address = GuestAddress.find_by(params[:id])

    respond_to do |format|
      if @address.update_attributes(address_params)
        format.html { redirect_to addresses_path, notice: 'Guest  address was successfully updated.' }
      else
        format.html { render action: 'edit' }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

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

  private

  def guest_params
    params.require(:guest).permit(:name,  :partner_name, :email, :password, :pax, :rsvp)
  end

  def validate_email_paramters(params)
    @result = {
        :success   => false,
        :error     => false,
        :validationMessages  => {}
    }
    if params[:guest_ids].blank?
      @result[:validationMessages].merge!({:no_guests => 'Please select guests to email'})
    end

    if params[:mail_template].blank?
      @result[:validationMessages].merge!({:no_template =>'Please select a mail template'})
    end

    if @result[:validationMessages].blank?
      @result[:success] = true
    else
      @result[:error] = true
    end

    return @result

  end

end