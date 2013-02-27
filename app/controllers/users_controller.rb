class UsersController < Clearance::UsersController
  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in(@user)
      redirect_to params[:callback] || root_url
    else
      render :new
    end
  end

  def unvisit
    sign_out()
    redirect_to params[:callback] || root_url
  end

  def visit
    puts('=======================================================================')
    puts(params[:email])
    puts('=======================================================================')
  	@user = User.find_or_create_by_email(:email => params[:email],
                                     :password => 'password',
                                     :password_confirmation => 'password')
    if @user
      sign_in(@user)
    end
    redirect_to params[:callback] || root_url


    # @conteudo = "{'login_status':1}"
  	# respond_to do |format|
	  #   format.json { render :json => @conteudo }
	  # end
  end
end
