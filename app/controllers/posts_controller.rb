class PostsController < ApplicationController
	def new

	end
	private

	def post_params
		params.require(:post).permit(:title,:user_id)
	end

	def set_user
		@user = current_user
	end

end
