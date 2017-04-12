class CommentsController < ApplicationController
  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.create(comment_params)
    @comment.created_by = current_user

    @comment.save

    redirect_to story_path(@story)
  end

  # PATCH/PUT /comments/1
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:story_id, :body)
    end
end
