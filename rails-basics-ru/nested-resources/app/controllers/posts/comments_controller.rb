# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    before_action :set_comment, only: %i[edit update destroy]
    before_action :set_post, only: %i[edit update destroy]

    def create
      @post = Post.find(params[:post_id])
      @comment = @post.post_comments.build(comment_params)
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully created.'
      else
        redirect_to @post, notice: "Error: Body #{@comment.errors[:body].join '. '}"
      end
      # debugger
    end

    def edit; end

    def update
      if @comment.update comment_params
        redirect_to @post, notice: 'Comment was successfully created.'
      else
        redirect_to @post, notice: "Error: Body #{@comment.errors[:body].join '. '}"
      end
    end

    def destroy
      @comment.destroy

      redirect_to @post, notice: 'Comment successfully deleted'
    end

    private

    def set_post
      @post = @comment.post
    end

    def set_comment
      @comment = PostComment.find(params[:id])
    end

    def comment_params
      params.require(:post_comment).permit(:body, :post_id)
    end
  end
end
