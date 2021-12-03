require 'json'

class Api::V1::PostsController < ApplicationController
  # uncomment if testing with postman or CORS
  protect_from_forgery with: :null_session

  def index
    @post = Post.all.where(helperStatus: false)
    ActiveRecord::Base.include_root_in_json = false
    json_post = JSON.parse(@post.to_json)
    json_post.each do |p|
      #@comments = Comment.find_by(commentee: p['email'])
      @comments = Comment.where(commentee: p['email'])
      p['comments'] = JSON.parse(@comments.to_json)
    end
    render json: json_post
  end

  def create
    post = Post.create!(post_params)
    render json: post
  end

  def cur_posts
    post = Post.where({email: current_user.email, requesterComplete: false}).order(created_at: :desc)
    render json: post
  end

  def pre_posts
    post = Post.where({email: current_user.email, requesterComplete: true, helperComplete: true}).order(created_at: :desc)
    render json: post
  end

  def help_history
    post = Post.where(helperEmail: current_user.email).order(created_at: :desc)
    render json: post
  end

  def comment
    Comment.create!(content: params[:content], postID: params[:post_id], commenter: params[:commenter])
    render json: {"message": "ok"}
  end

  def comment_list
    comments = Comment.where(postID: params[:post_id]).order(created_at: :desc)
    render json: comments.to_json
  end

  def help
    begin
      post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      post = nil
    end
    if post
      unless post.helperStatus
        post.update(helperStatus: true, helperEmail: current_user.email)
      end
      render json: post
    else
      render json: { error: "Post not found!" }, status: 404
    end
  end

  def cancel
    begin
      post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      post = nil
    end
    if post
      if post.helperStatus and post.helperEmail == current_user.email
        post.update(helperStatus: false, helperEmail: nil)
      end
      render json: post
    else
      render json: { error: "Post not found!" }, status: 404
    end
  end

  def complete
    begin
      post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      post = nil
    end
    if post
      if post.helperStatus and post.helperEmail == current_user.email
        post.update(helperComplete: true)
      end
      render json: post
    else
      render json: { error: "Post not found!" }, status: 404
    end
  end

  def show
    begin
      post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      post = nil
    end
    if post
      render json: post
    else
      render json: { error: "Post not found!" }, status: 404
    end
  end

  def update
    begin
      post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      post = nil
    end
    unless post
      render json: { error: "Post not found!" }, status: 404
      return
    end
    if post.update(update_params)
      render json: { message: 'Post updated!' }
    else
      render json: { error: 'Failed to update the post!' }, status: 400
    end
  end

  # Note: below will be implemented in next iteration
  # def destroy
  #   post&.destroy
  #   render json: { message: 'Post deleted!' }
  # end

  def post_params
    params.require(:post).permit(:title, :location, :startTime, :endTime, :taskDetails, :credit, :email, :helperStatus, :helperEmail, :helperComplete, :requesterComplete).with_defaults(helperStatus: false, helperEmail: "null", helperComplete: false, requesterComplete: false)
  end

  def update_params
    params.permit(:title, :location, :startTime, :endTime, :taskDetails, :credit)
  end

end
