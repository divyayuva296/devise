class PostsController < ApplicationController
	before_action :set_post , only: [:delete_photo]
	
	def index
		@posts = Post.all
	end

	def new
		@user = current_user
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end

	def create
	
		@user = current_user
		@post = @user.posts.create(post_params)
		@post.photo.attach(params[:post][:photo])
		@post.photos.attach(params[:post][:photos])

		if @post.save
			redirect_to posts_path
		else
			render 'new'
		
		end
	end

	def update
		@post = current_user.posts.find(params[:id])
		# byebug
		if @post.update(post_params)
			redirect_to posts_path
		else
			render 'edit'
		end
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		@post.destroy
		# remove_image_at_index(params[:id].to_i)
		# byebug
		redirect_to posts_path
	end
	def delete_avatar

		@post = Post.find(params[:id])
		# remove_image_at_index(params[:id].to_i)
		@post.avatar.destroy
		redirect_to post_path
	end

	def delete_photo
			# binding.pry
		@image = ActiveStorage::Attachment.find_by_record_id(params[:id])

		@image.purge
		redirect_to post_path	
	end

	private
	def post_params
    	params.require(:post).permit(:title, :user_id,:avatar,:photo,:image,:feature_image,{images: []},photos: [],feature_images: [])
    end

    def remove_image_at_index(index)
    	remain_images = @post.images
    	# byebug
    	deleted_image = remain_images.delete_at(index)
    	deleted_image.try(:remove!)
    	@post.images = remain_images
   end 
   def set_post
   	@post = Post.find(params[:id])
   	
   end

end
