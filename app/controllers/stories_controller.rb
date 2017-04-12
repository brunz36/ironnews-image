class StoriesController < ApplicationController
  before_action :authorize!, except: [:index]

  # GET /stories
  def index
    @stories = Story.all.order(created_at: :desc).page params[:page]
  end

  # GET /stories/1
  def show
    @story = Story.find(params[:id])
    @comment = Comment.find_by(params[:story_id])
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])

    unless @story.can_this_user_edit?(current_user)
      redirect_to stories_path, notice: 'You may not edit other users posts.'
      return
    end
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    @story.created_by = current_user

    if @story.save
      redirect_to @story, notice: 'Story was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /stories/1
  def update
    @story = Story.find(params[:id])

    unless @story.can_this_user_edit?(current_user)
      redirect_to stories_path, notice: 'You may not edit other users posts.'
      return
    end

    if @story.update(story_params)
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /stories/1
  def destroy
    @story = Story.find(params[:id])

    unless @story.can_this_user_destroy?(current_user)
      redirect_to stories_path, notice: 'You may not delete other users posts.'
    else
      @story.destroy
      redirect_to stories_url, notice: 'Story was successfully destroyed.'
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def story_params
    params.require(:story).permit(:title, :url_link, :image)
  end
end
