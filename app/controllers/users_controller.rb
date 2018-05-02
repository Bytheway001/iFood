class UsersController < ApplicationController
	def profile
		@user=current_user
	end

	def update
		if current_user.update(user_params)
			redirect_to root_path
		else
			redirect_to user_profile_path
		end
	end

	def user_params
		params.require(:user).permit(:nombre,:direccion,:cep,:lat,:long)
	end

	
end
