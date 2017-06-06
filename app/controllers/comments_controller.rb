class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    if session[:user_id] == nil || @current_user.role != 'admin'
      flash[:not_admin] = "Vous ne faites pas partie de l'équipe d'administration !"
      redirect_to "/advertisements"
    else
      @comments = Comment.all
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    if session[:user_id] == nil || @current_user.role != 'admin'
      flash[:not_admin] = "Vous ne faites pas partie de l'équipe d'administration !"
      redirect_to "/advertisements"
    else
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    if session[:user_id] == nil || @current_user.role != 'admin'
      flash[:not_admin] = "Vous ne faites pas partie de l'équipe d'administration !"
      redirect_to "/advertisements"
    else
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params.merge!(user_id: session[:user_id]))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to advertisements_path, notice: 'Le commentaire a bien été créé !' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :content, :advertisement_id)
    end
end
