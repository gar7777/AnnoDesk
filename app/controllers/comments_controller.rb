class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @announcement = Announcement.find(params[:announcement_id])
    @comment = @announcement.comments.create(comment_params)

    #@comment = Comment.new(comment_params)

    redirect_to announcement_path(@announcement)
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @announ_id = @comment.announcement_id
    @announcement = Announcement.find(@announ_id)
    @comment = @announcement.comments.create(comment_params)

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

    #redirect_to announcement_path(@announcement)
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @announ_id = @comment.announcement_id
    @announcement = Announcement.find(@announ_id)
    @comment.destroy
    #@announcement = current_announcement

    redirect_to announcement_path(@announcement)
    #respond_to do |format|
    #  format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:text, :user_id, :announcement_id)
    end
end
