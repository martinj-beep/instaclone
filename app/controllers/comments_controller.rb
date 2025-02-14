class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create]  # Ensure only new and create actions need set_post
  before_action :set_comment, only: %i[show edit destroy]  # Set comment only for show, edit, destroy

  def new
    @comment = @post.comments.new  # Initialize a new comment for the post
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user  # Associate the comment with the current user

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      render :new  # If comment wasn't saved, render new form again
    end
  end

  def show
    # Show action logic for comments
  end

  def edit
    # Edit action logic for comments
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])  # Find the post using post_id
  end

  def set_comment
    @comment = @post.comments.find(params[:id])  # Find the comment under the post by ID
  end

  def comment_params
    params.require(:comment).permit(:text)  # Permit only the text parameter for the comment
  end
end

1:28:33