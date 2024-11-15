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
    @writing = Writing.find(params[:writing_id]) # Get the parent writing
    @comment = @writing.comments.build(comment_params) # Build comment associated with writing
    @comment.user = current_user # Associate the comment with the logged-in user (if using Devise)

    if @comment.save
      redirect_to writing_path(@writing), notice: "Comment was successfully created."
    else
      redirect_to writing_path(@writing), alert: "Failed to create comment."
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!
  
    respond_to do |format|
      format.html { redirect_to writing_path(@comment.writing), status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find_by(id: params[:id], writing_id: params[:writing_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :review, :writing_id)
    end

    def comment_params_no_writing_id
      params.require(:comment).permit(:content, :review)
    end

    def set_resource
      if action_name.in?(['edit', 'update', 'destroy'])
        @resource = Comment.find(params[:id])
      end
    end
end
