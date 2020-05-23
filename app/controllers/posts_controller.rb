class PostsController < ApplicationController

	before_action :set_post, only: [:show, :edit, :update, :destroy]
  	include SmartListing::Helper::ControllerExtensions
  	helper  SmartListing::Helper

	def index
		posts_scope = Post.all
		posts_scope = posts_scope.like(params[:filter]) if params[:filter]
		smart_listing_create :posts, posts_scope, partial: "posts/list"
	
	end

	def show

		@post = Post.find(params[:id])

	end

	def new
		@post = Post.new
	end

	def create

		@post = Post.new(post_params)

		if(@post.save)
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if(@post.update(post_params))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private
	def set_post
      @post = Post.find(params[:id])
    end

	def post_params
		params.require(:post).permit(:title, :body)
	end
end
