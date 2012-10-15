class UsersController < Clearance::UsersController
	def login_from_gabinete_digital
		logger.info "Validando login para o GD"
		# logger.info params
		logger.info "\n\nemail:"+params[:email]
		logger.info "gd_id:"+params[:gd_id]

		user = User.find_or_create_by_email(params[:email])
	    user.gabinetedigital_id = params[:gd_id]
	    user.password = User.random_password if user.new_record?
	    user.save

	    sign_in(user)

	    user
	end

end
